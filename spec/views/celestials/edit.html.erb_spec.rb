require 'rails_helper'

RSpec.describe "celestials/edit", type: :view do
  before(:each) do
    @celestial = assign(:celestial, Celestial.create!(
      :birthday => nil,
      :name => "MyString"
    ))
  end

  it "renders the edit celestial form" do
    render

    assert_select "form[action=?][method=?]", celestial_path(@celestial), "post" do

      assert_select "input[name=?]", "celestial[birthday_id]"

      assert_select "input[name=?]", "celestial[name]"
    end
  end
end
