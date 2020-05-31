class AddDefaultValueToStatus < ActiveRecord::Migration[6.0]
  def change
    change_column :cat_rental_requests, :status, :string, :default => "PENDING"
  end
end
