class AddNopenalityToIncident < ActiveRecord::Migration[5.2]
  def change
    add_column :incidents, :Nopenality, :boolean
  end
end
