require 'rails_helper'

RSpec.describe "celestials/show", type: :view do
  before(:each) do
    @celestial = assign(:celestial, Celestial.create!(
      :birthday => nil,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
  end
end
