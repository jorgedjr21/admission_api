class AddStudentToAdmissions < ActiveRecord::Migration[5.2]
  def change
    add_reference :admissions, :student, foreign_key: true
  end
end
