class DeliveriesController < ApplicationController
  def entrance
    @date = rand(Date.civil(1900)...Date.civil(1901))
    if params[:spread_direction] == 'vertical'
      session[:vertical_spread] = true
    end
  end
  
  def access
    @birthday = Birthday.find params[:id]
    @birth_card = @birthday.birth_card
    @personality_card = @birthday.personality_card
    @birthday_card = YAML.load(File.read(Rails.root.join('config', 'birthday_cards.yml')))[@birthday.month]&.[] @birthday.day
  end
end
