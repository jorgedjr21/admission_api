class RemoveStudentIdFromBillings < ActiveRecord::Migration[5.2]
  def change
    remove_column :billings, :student_id
  end
end
