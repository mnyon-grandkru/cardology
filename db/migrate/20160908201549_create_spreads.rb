class CreateSpreads < ActiveRecord::Migration[5.0]
  def change
    create_table :spreads do |t|
      t.integer :age

      t.timestamps
    end
  end
end
