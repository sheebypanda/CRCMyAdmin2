class RenameNopenality < ActiveRecord::Migration[5.2]
  def change
    rename_column :incidents, :Nopenality, :nopenality
  end
end
