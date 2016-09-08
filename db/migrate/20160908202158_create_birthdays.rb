class CreateBirthdays < ActiveRecord::Migration[5.0]
  def change
    create_table :birthdays do |t|
      t.integer :year
      t.integer :month
      t.integer :day

      t.timestamps
    end
  end
end
