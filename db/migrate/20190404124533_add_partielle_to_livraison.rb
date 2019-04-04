class AddPartielleToLivraison < ActiveRecord::Migration[5.2]
  def change
    add_column :livraisons, :partielle, :boolean
  end
end
