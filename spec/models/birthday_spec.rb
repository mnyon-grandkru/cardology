require 'rails_helper'

RSpec.describe Birthday, type: :model do
  it "can print out its birthdate" do
    @birthday = Fabricate :birthday, :month => 4
    expect(@birthday.name).to include('April')
  end
  
  describe "planetary card" do
    it "for current planet" do
      @birthday = Fabricate :birthday, :year => 1980, :month => 8, :day => 20
      travel_to Time.zone.local(2018, 2, 4, 1, 0, 0)
      @planetary_card = @birthday.card_for_this_planet
      expect(@planetary_card.name).to include('Two of Spades')
    end
  end
end
