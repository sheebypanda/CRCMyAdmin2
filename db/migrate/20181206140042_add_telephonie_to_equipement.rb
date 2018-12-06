class AddTelephonieToEquipement < ActiveRecord::Migration[5.2]
  def change
    add_column :equipements, :telephonie, :boolean
  end
end
