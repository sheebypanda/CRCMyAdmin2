class AddSlaToEquipements < ActiveRecord::Migration[5.1]
  def change
    add_column :equipements, :sla, :string
  end
end
