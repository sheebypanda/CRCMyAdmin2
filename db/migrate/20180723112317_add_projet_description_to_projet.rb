class AddProjetDescriptionToProjet < ActiveRecord::Migration[5.1]
  def change
    add_column :projets, :description, :text
  end
end
