# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint           not null, primary key
#  end_date   :date             not null
#  start_date :date             not null
#  status     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cat_id     :integer          not null
#
# Indexes
#
#  index_cat_rental_requests_on_cat_id  (cat_id)
#
class CatRentalRequest < ApplicationRecord
end
