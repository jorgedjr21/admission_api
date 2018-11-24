class FixMethodColumnNameInPayments < ActiveRecord::Migration[5.2]
  def change
    rename_column :payments, :method, :payment_method
  end
end
