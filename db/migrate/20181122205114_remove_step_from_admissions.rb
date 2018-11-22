class RemoveStepFromAdmissions < ActiveRecord::Migration[5.2]
  def change
    remove_column :admissions, :step, :string
  end
end
