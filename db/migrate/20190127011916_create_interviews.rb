class CreateInterviews < ActiveRecord::Migration[5.1]
  def change
    create_table :interviews do |t|
      t.boolean :expected
      t.boolean :frequent
      t.boolean :useful
      t.text :thoughts
      t.belongs_to :member, foreign_key: true
      t.string :braintree_subscription_id

      t.timestamps
    end
  end
end
