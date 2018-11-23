class AddParcelsNumberToBillings < ActiveRecord::Migration[5.2]
  def change
    add_column :billings, :parcels_number, :integer, default: 0
  end
end
