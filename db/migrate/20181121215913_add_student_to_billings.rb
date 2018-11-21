class AddStudentToBillings < ActiveRecord::Migration[5.2]
  def change
    add_reference :billings, :student, foreign_key: true
  end
end
