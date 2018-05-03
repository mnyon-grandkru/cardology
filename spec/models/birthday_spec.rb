require 'rails_helper'

RSpec.describe Birthday, type: :model do
  it "can print out its birthdate" do
    @birthday = Fabricate :birthday, :month => 4
    expect(@birthday.name).to include('April')
  end
  
  describe "calculating age" do
    context "on birthday" do
      before do
        @birthday = Fabricate :birthday, :year => 1984, :month => 4, :day => 8
      end
      
      after do
        travel_back
      end
      
      context "age 10" do
        it "should be incremented" do
          tenth_birthday = Time.zone.local(1994, 4, 8, 12, 0, 0).to_date
          expect(@birthday.age_on_date(tenth_birthday)).to eq(10)
        end
      end
      
      context "age 34" do
        it "should be incremented" do
          thirty_fourth_birthday = Time.zone.local(2018, 4, 8, 12, 0, 0).to_date
          expect(@birthday.age_on_date(thirty_fourth_birthday)).to eq(34)
        end
      end
    end
  end
  
  context "birthday in August 1980" do
    before do
      @birthday = Fabricate :birthday, :year => 1980, :month => 8, :day => 20
    end
    
    after do
      travel_back
    end
    
    describe "planetary card in February 2018" do
      before do
        travel_to Time.zone.local(2018, 2, 4, 1, 0, 0)
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
    
    describe "planetary card just before birthday" do
      before do
        travel_to Time.zone.local(2018, 8, 19, 1, 0, 0)
      end
      
      it "for current planet" do
        @planetary_card = @birthday.card_for_this_planet
        expect(@planetary_card.name).to include('Joker')
      end
    
      it "for approaching planet" do
        @planetary_card = @birthday.card_for_next_planet
        expect(@planetary_card.name).to include('Four of Diamonds')
      end
    end
  end
  
  context "birthday in October 1968" do
    before do
      @birthday = Fabricate :birthday, :year => 1968, :month => 10, :day => 8
    end
    
    after do
      travel_back
    end
    
    describe "daily card" do
      it "has two love affairs in January 2018" do
        travel_to Time.zone.local(2018, 1, 21, 1, 0, 0)
        @jan21 = @birthday.card_for_today
        travel_to Time.zone.local(2018, 1, 23, 1, 0, 0)
        @jan23 = @birthday.card_for_today
        expect(@jan21.name).to include('Two of Hearts')
        expect(@jan23.name).to include('Two of Hearts')
      end
    end
  end
  
  context "birthday in April 1984" do
    before do
      @birthday = Fabricate :birthday, :year => 1984, :month => 4, :day => 8
    end
    
    after do
      travel_back
    end
    
    context "before 34th birthday" do
      before do
        travel_to Time.zone.local(2018, 4, 7, 12, 0, 0)
      end
      
      describe "yearly card" do
        it "for this year is Eight of Hearts" do
          expect(@birthday.card_for_this_year.name).to include("Eight of Hearts")
        end
      end
    end
    
    context "on 34th birthday" do
      before do
        travel_to Time.zone.local(2018, 4, 8, 12, 0, 0)
      end
      
      describe "yearly card" do
        it "for this year is Ten of Clubs" do
          expect(@birthday.card_for_this_year.name).to include("Ten of Clubs")
        end
      end
    end
  end
end
