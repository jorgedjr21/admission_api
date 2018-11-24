class AddBillingToPayments < ActiveRecord::Migration[5.2]
  def change
    add_reference :payments, :billing, foreign_key: true
  end
end
