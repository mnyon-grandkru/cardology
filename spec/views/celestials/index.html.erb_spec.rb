require 'rails_helper'

RSpec.describe "celestials/index", type: :view do
  before(:each) do
    assign(:celestials, [
      Celestial.create!(
        :birthday => nil,
        :name => "Name"
      ),
      Celestial.create!(
        :birthday => nil,
        :name => "Name"
      )
    ])
  end

  it "renders a list of celestials" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
