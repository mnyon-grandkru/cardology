class CreateLookups < ActiveRecord::Migration[5.0]
  def change
    create_table :lookups do |t|
      t.belongs_to :birthday, foreign_key: true
      t.string :ip_address

      t.timestamps
    end
  end
end
