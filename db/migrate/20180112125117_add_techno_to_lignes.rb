class AddTechnoToLignes < ActiveRecord::Migration[5.1]
  def change
    add_column :lignes, :techno, :string
  end
end
