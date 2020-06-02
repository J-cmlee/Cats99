# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint           not null, primary key
#  end_date   :date             not null
#  start_date :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cat_id     :integer          not null
#
# Indexes
#
#  index_cat_rental_requests_on_cat_id  (cat_id)
#
class CatRentalRequest < ApplicationRecord
    #use .freeze to redner contants immutable
    STATUS_STATES = %w(APPROVED DENIED PENDING).freeze

    validates :status, inclusion: STATUS_STATES
    validates :cat_id, :end_date, :start_date, :status, presence: true
    validate :does_not_overlap_approved_request
    validate :start_must_come_before_end

    belongs_to :cat

    #Methods
    def approved?
        self.status == 'APPROVED'
    end

    def denied?
        self.status == 'DENIED'
    end

    def pending?
        self.status == 'PENDING'
    end

    #Assign deny status
    def deny!
        self.status = 'DENIED'
        self.save!
    end

    #Assign pending status (only if it did not have a status before)
    #This is likely redundant as the schema has an initial value of PENDING
    def assign_pending_status
        self.status ||= 'PENDING'
    end

    #determine requests that clash with the approved data block.
    #Logic = First determine conditions where two requests do not clash
    #then select the negative of the condition for clashes
    def overlapping_requests
        CatRentalRequest
            .where.not(id: self.id) #remove self from list
            .where(cat_id: cat_id)
            .where.not("start_date > :end_date OR end_date < :start_date",
            start_date: start_date, end_date: end_date)
    end

    def overlapping_approved_requests
        overlapping_requests.where("status = 'APPROVED'")
    end

    def overlapping_pending_requests
        overlapping_requests.where("status = 'PENDING'")
    end

    #approval requires a transaction (all actions must not throw an error)
    def approve!
        raise 'Not Pending' if (self.status != 'PENDING')
        transaction do
            self.status = 'APPROVED'
            self.save!

            #Reject of all overlapping requests for this cat
            overlapping_approved_requests.each do |ele|
                ele.update!(status: "DENIED")
            end
        end
    end

    #---VALIDATIONS---
    #if the request is set to DENIED, then there is no need for a check
    #if there is a overlap, then place an error
    def does_not_overlap_approved_request
        return if self.denied?
        
        if (overlapping_approved_requests.empty? == false)
            errors[:base] << "Request conflicts with existing approved request"
        end

    end

    #Check that the start date does not come after end date
    def start_must_come_before_end
        return if start_date < end_date
        errors[:start_date] << 'must come before end date'
        errors[:end_date] << 'must come after start date'
    end
    

end
