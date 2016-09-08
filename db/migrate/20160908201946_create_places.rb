class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.belongs_to :card, foreign_key: true
      t.belongs_to :spread, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
