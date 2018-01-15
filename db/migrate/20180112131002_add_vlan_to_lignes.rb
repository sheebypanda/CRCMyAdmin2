class AddVlanToLignes < ActiveRecord::Migration[5.1]
  def change
    add_column :lignes, :vlan, :string
  end
end
