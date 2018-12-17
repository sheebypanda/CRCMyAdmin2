class RemoveSupervisionFromEquipements < ActiveRecord::Migration[5.2]
  def change
    remove_column :equipements, :supervision, :boolean
  end
end
