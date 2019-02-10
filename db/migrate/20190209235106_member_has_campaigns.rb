class MemberHasCampaigns < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :campaigns, :text
  end
end
