class ChangeSlaToInteger < ActiveRecord::Migration[5.1]
  def change
    change_column :equipements, :sla, :integer, using: 'sla::integer'
  end
end
