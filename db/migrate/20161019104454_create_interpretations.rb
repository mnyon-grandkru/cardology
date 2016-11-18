class CreateInterpretations < ActiveRecord::Migration[5.0]
  def change
    create_table :interpretations do |t|
      t.references :card, foreign_key: true
      t.text :explanation
      t.integer :reading

      t.timestamps
    end
  end
end
