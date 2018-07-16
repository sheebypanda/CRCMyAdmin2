class AddProjetReferenceToEquipement < ActiveRecord::Migration[5.1]
  def change
    add_column :equipements, :projet_id, :bigint
  end
end
