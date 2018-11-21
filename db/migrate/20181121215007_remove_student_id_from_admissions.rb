class RemoveStudentIdFromAdmissions < ActiveRecord::Migration[5.2]
  def change
    remove_column :admissions, :student_id
  end
end
