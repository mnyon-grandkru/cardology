class NumberFaces < ActiveRecord::Migration[5.0]
  def change
    add_column :faces, :number, :integer
  end
end
