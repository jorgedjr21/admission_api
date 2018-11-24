class ChangeStatusInBillsToInteger < ActiveRecord::Migration[5.2]
  def change
    remove_column :admissions, :status
    add_column :admissions, :status, :integer
  end
end
