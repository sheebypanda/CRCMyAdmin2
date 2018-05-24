class AddRattachementToLocalisation < ActiveRecord::Migration[5.1]
  def change
    add_column :localisations, :rattachement, :string
  end
end
