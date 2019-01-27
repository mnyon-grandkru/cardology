require 'rails_helper'

RSpec.describe "interviews/index", type: :view do
  before(:each) do
    assign(:interviews, [
      Interview.create!(
        :expected => false,
        :frequent => false,
        :useful => false,
        :thoughts => "MyText",
        :member => nil,
        :braintree_subscription_id => "Braintree Subscription"
      ),
      Interview.create!(
        :expected => false,
        :frequent => false,
        :useful => false,
        :thoughts => "MyText",
        :member => nil,
        :braintree_subscription_id => "Braintree Subscription"
      )
    ])
  end

  it "renders a list of interviews" do
    render
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Braintree Subscription".to_s, :count => 2
  end
end
