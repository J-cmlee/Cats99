# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  birth_date  :date
#  color       :string
#  description :text
#  name        :string
#  sex         :string(1)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Cat < ApplicationRecord
    COLORS = %w(Black White Gray Red Brown).freeze
    validates :birth_date, presence: true
    validates :color, inclusion: COLORS
    validates :sex, inclusion: {in: %w(M F)}

    has_many :cat_rental_requests, dependent: :destroy

    def age
        return Date.today.year - birth_date.year
    end
end
