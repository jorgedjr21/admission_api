class CreateAdmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :admissions do |t|
      t.integer :student_id
      t.string  :step
      t.integer :enem_grade

      t.timestamps
    end
  end
end
