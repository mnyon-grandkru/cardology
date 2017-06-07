require 'rails_helper'

RSpec.describe Birthday, type: :model do
  it "can print out its birthdate" do
    @birthday = Fabricate :birthday, :month => 4
    expect(@birthday.name).to include('April')
  end
end
