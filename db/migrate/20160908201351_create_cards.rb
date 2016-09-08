class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.belongs_to :suit, foreign_key: true
      t.belongs_to :face, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
