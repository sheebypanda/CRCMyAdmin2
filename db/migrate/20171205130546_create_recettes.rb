class CreateRecettes < ActiveRecord::Migration[5.1]
  def change
    create_table :recettes do |t|
      t.references :user, foreign_key: true
      t.references :equipement, foreign_key: true
      t.references :ligne, foreign_key: true
      t.references :localisation, foreign_key: true
      t.boolean :snmp
      t.boolean :tacacs
      t.boolean :testdebit
      t.boolean :supervision
      t.boolean :etiquette

      t.timestamps
    end
  end
end
