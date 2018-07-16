class CreateProjets < ActiveRecord::Migration[5.1]
  def change
    create_table :projets do |t|
      t.references :user, foreign_key: true
      t.string :titre
      t.date :date

      t.timestamps
    end
  end
end
