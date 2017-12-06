class CreateLocalisations < ActiveRecord::Migration[5.1]
  def change
    create_table :localisations do |t|
      t.string :nom
      t.string :adresse
      t.integer :codepostal
      t.string :ville
      t.integer :etage
      t.string :tel
      t.string :mail
      t.text :description
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
