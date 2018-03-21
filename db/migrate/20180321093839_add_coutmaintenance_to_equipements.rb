class AddCoutmaintenanceToEquipements < ActiveRecord::Migration[5.1]
  def change
    add_column :equipements, :coutmaintenance, :float
  end
end
