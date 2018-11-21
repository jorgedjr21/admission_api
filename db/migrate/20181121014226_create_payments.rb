class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.numeric   :value
      t.string    :status
      t.string    :method
      t.datetime  :expiry_date

      t.timestamps
    end
  end
end
