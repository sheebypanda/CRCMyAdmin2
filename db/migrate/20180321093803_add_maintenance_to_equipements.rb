class AddMaintenanceToEquipements < ActiveRecord::Migration[5.1]
  def change
    add_column :equipements, :maintenance, :boolean
  end
end
