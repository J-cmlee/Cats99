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
    COLORS = "black white gray"
    validates :birth_date, presence: true
    validates :color, inclusion: {in: %w(Black White Gray)}
    validates :sex, inclusion: {in: %w(M F)}

    def age
        return Date.today.year - birth_date.year
    end
end
