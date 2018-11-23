class ChangeStatusInBillsToInteger < ActiveRecord::Migration[5.2]
  def change
    change_column :bills, :status, :integer
  end
end
