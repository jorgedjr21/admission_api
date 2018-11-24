class ChangeStatusInBillingToInteger < ActiveRecord::Migration[5.2]
  def change
    change_column :billings, :status, :integer
  end
end
