require 'rails_helper'

RSpec.describe "celestials/new", type: :view do
  before(:each) do
    assign(:celestial, Celestial.new(
      :birthday => nil,
      :name => "MyString"
    ))
  end

  it "renders new celestial form" do
    render

    assert_select "form[action=?][method=?]", celestials_path, "post" do

      assert_select "input[name=?]", "celestial[birthday_id]"

      assert_select "input[name=?]", "celestial[name]"
    end
  end
end
