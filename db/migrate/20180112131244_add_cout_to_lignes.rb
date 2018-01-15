class AddCoutToLignes < ActiveRecord::Migration[5.1]
  def change
    add_column :lignes, :cout, :float
  end
end
