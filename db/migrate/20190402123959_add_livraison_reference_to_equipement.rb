class AddLivraisonReferenceToEquipement < ActiveRecord::Migration[5.2]
  def change
    add_column :equipements, :livraison_id, :bigint
  end
end
