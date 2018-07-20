class CreateIncidentEquipementJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :incidents, :equipements
  end
end
