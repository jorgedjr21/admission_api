class CreateBillings < ActiveRecord::Migration[5.2]
  def change
    create_table :billings do |t|
      t.integer :student_id
      t.integer :desired_due_day
      t.string  :status

      t.timestamps
    end
  end
end
