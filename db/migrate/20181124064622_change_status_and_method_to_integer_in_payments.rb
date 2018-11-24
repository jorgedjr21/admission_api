class ChangeStatusAndMethodToIntegerInPayments < ActiveRecord::Migration[5.2]
  def change
    change_column :payments, :status, :integer
    change_column :payments, :method, :integer
  end
end
