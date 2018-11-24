class AddBillToPayments < ActiveRecord::Migration[5.2]
  def change
    add_reference :payments, :bill, foreign_key: true
  end
end
