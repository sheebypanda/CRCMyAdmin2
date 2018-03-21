class AddDatemaintenanceToEquipements < ActiveRecord::Migration[5.1]
  def change
    add_column :equipements, :datemaintenance, :date
  end
end
