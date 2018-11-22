class AddStatusToAdmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :admissions, :status, :integer
  end
end
