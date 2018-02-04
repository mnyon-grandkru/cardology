require 'rails_helper'

RSpec.describe Birthday, type: :model do
  it "can print out its birthdate" do
    @birthday = Fabricate :birthday, :month => 4
    expect(@birthday.name).to include('April')
  end
  
  describe "planetary card" do
    before do
      @birthday = Fabricate :birthday, :year => 1980, :month => 8, :day => 20
      travel_to Time.zone.local(2018, 2, 4, 1, 0, 0)
    end
    
    after do
      travel_back
    end
    
    it "for current planet" do
      @planetary_card = @birthday.card_for_this_planet
      expect(@planetary_card.name).to include('Two of Spades')
    end
    
    it "for approaching planet" do
      @planetary_card = @birthday.card_for_next_planet
      expect(@planetary_card.name).to include('Ten of Diamonds')
    end
  end
end
