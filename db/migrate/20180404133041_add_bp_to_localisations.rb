class AddBpToLocalisations < ActiveRecord::Migration[5.1]
  def change
    add_column :localisations, :bp, :bigint
  end
end
