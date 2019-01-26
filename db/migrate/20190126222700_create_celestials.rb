class CreateCelestials < ActiveRecord::Migration[5.1]
  def change
    create_table :celestials do |t|
      t.belongs_to :birthday, foreign_key: true
      t.belongs_to :member, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
