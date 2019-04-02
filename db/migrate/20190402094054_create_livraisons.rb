class CreateLivraisons < ActiveRecord::Migration[5.2]
  def change
    create_table :livraisons do |t|
      t.references :user, foreign_key: true
      t.string :nom
      t.string :commande
      t.text :commentaire

      t.timestamps
    end
  end
end
