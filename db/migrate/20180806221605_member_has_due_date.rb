class MemberHasDueDate < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :due_date, :datetime
  end
end
