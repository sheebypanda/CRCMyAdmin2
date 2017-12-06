class CreateOperateurs < ActiveRecord::Migration[5.1]
  def change
    create_table :operateurs do |t|
      t.string :nom
      t.string :hotline

      t.timestamps
    end
  end
end
