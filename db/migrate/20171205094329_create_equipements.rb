class CreateEquipements < ActiveRecord::Migration[5.1]
  def change
    create_table :equipements do |t|
      t.string :nom
      t.string :marque
      t.string :modele
      t.string :snmpcontact
      t.string :dns
      t.string :iosv
      t.string :ip
      t.date :achat
      t.integer :garantie
      t.string :asapid
      t.string :serial

      t.timestamps
    end
  end
end
