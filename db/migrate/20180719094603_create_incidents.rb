class CreateIncidents < ActiveRecord::Migration[5.1]
  def change
    create_table :incidents do |t|
      t.references :user, foreign_key: true
      t.datetime :debut
      t.datetime :fin
      t.string :idnxo
      t.string :idasap
      t.text :commentaire

      t.timestamps
    end
  end
end
