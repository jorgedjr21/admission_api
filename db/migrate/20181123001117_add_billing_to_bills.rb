class AddBillingToBills < ActiveRecord::Migration[5.2]
  def change
    add_reference :bills, :billing, foreign_key: true
  end
end
