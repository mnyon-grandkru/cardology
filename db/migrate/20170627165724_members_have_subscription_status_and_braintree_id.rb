class MembersHaveSubscriptionStatusAndBraintreeId < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :braintree_id, :string
    add_column :members, :subscription_status, :integer
  end
end
