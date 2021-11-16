class DeliveriesController < ApplicationController
  def entrance
    @date = DateTime.now
  end
  
  def access
    @birthday = Birthday.find params[:id]
    @birth_card = @birthday.birth_card
    @personality_card = @birthday.personality_card
    @birthday_card = YAML.load(File.read(Rails.root.join('config', 'birthday_cards.yml')))[@birthday.month]&.[] @birthday.day
  end
end
