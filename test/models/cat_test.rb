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
require 'test_helper'

class CatTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
