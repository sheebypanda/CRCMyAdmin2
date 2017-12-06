class CreateLignes < ActiveRecord::Migration[5.1]
  def change
    create_table :lignes do |t|
      t.string :numerocompte
      t.string :ndi
      t.float :debit
      t.string :ippublique
      t.string :mail
      t.string :tel
      t.string :identifiantoperateur
      t.string :mdpoperateur
      t.string :compte
      t.string :motdepasse
      t.references :operateur, foreign_key: true

      t.timestamps
    end
  end
end
