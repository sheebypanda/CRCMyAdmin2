class AddHonoraireToEquipement < ActiveRecord::Migration[5.2]
  def change
    add_column :equipements, :Honoraire, :float
  end
end
