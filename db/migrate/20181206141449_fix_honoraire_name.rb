class FixHonoraireName < ActiveRecord::Migration[5.2]
  def self.up
    rename_column :equipements, :Honoraire, :honoraire
  end
end
