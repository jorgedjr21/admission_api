class ChangeStatusAndMethodToIntegerInPayments < ActiveRecord::Migration[5.2]
  def change
    remove_column :payments, :status
    add_column    :payments, :status, :integer

    remove_column :payments, :method
    add_column :payments,    :method, :integer
  end
end
