require 'rails_helper'

RSpec.describe "interviews/show", type: :view do
  before(:each) do
    @interview = assign(:interview, Interview.create!(
      :expected => false,
      :frequent => false,
      :useful => false,
      :thoughts => "MyText",
      :member => nil,
      :braintree_subscription_id => "Braintree Subscription"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Braintree Subscription/)
  end
end
