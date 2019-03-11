class AddNomailToIncident < ActiveRecord::Migration[5.2]
  def change
    add_column :incidents, :nomail, :boolean
  end
end
