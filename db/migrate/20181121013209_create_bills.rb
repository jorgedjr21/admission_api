class CreateBills < ActiveRecord::Migration[5.2]
  def change
    create_table :bills do |t|
      t.numeric   :value
      t.datetime  :due_date
      t.datetime  :paid_date
      t.string    :status
      t.integer   :month
      t.integer   :year

      t.timestamps
    end
  end
end
