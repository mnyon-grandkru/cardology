class SubscriptionIdentifiers < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :subscriptions, :text
    Member.update_all :subscriptions => []
  end
end
