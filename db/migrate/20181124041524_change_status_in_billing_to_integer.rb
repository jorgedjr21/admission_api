class ChangeStatusInBillingToInteger < ActiveRecord::Migration[5.2]
  def change
    remove_column :billings, :status
    add_column :billings, :status, :integer
  end
end
