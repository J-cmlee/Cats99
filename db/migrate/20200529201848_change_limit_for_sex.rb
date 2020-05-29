class ChangeLimitForSex < ActiveRecord::Migration[6.0]
  def change
    change_column :cats, :sex, :string, limit:1
  end
end
