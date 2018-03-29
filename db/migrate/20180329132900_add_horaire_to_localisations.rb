class AddHoraireToLocalisations < ActiveRecord::Migration[5.1]
  def change
    add_column :localisations, :horaires, :text
  end
end
