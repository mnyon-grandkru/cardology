class WheelsController < ApplicationController
  def show
    @birthday = Birthday.find params[:birthday_id]
    @seven_year_cards = @birthday.seven_year_cards
    @thirteen_year_cards = @birthday.thirteen_year_cards
    @year_cards = @birthday.year_cards
    @planetary_cards = @birthday.planetary_cards
    @daily_cards = @birthday.daily_cards
  end
end
