class BirthdaysController < ApplicationController
  skip_before_action :verify_authenticity_token, :if => lambda { request.domain == 'herokuapp.com' }
  before_action :redirect_customer, :only => :index
  
  def index
    @birthdays = Birthday.all
  end
  
  def show
    @birthday = Birthday.find params[:id]
    @birth_card = @birthday.birth_card
    @personality_card = @birthday.personality_card
    @yearly_card = @birthday.card_for_this_year
    @planetary_card = @birthday.card_for_this_52_day_period
    @birth_card_explanation = @birth_card.interpretations.where(:reading => :birth).last&.explanation
    @personality_card_explanation = @personality_card.interpretations.where(:reading => :birth).last&.explanation
    @yearly_card_explanation = @yearly_card.interpretations.where(:reading => :yearly).last&.explanation
    @planetary_card_explanation = @planetary_card.interpretations.where(:reading => :yearly).last&.explanation
  end
  
  def last_year
    @birthday = Birthday.find params[:id]
    @yearly_card = @birthday.card_for_last_year
    @yearly_card_explanation = @yearly_card.interpretations.where(:reading => :yearly).last&.explanation
    @link_text = "See This Year's Card"
    @alternative_yearly_card_location = this_year_birthday_path(@birthday)
  end
  
  def this_year
    @birthday = Birthday.find params[:id]
    @yearly_card = @birthday.card_for_this_year
    @yearly_card_explanation = @yearly_card.interpretations.where(:reading => :yearly).last&.explanation
    @link_text = "See Last Year's Card"
    @alternative_yearly_card_location = last_year_birthday_path(@birthday)
    render :template => 'birthdays/last_year.js.erb'
  end
  
  def last_planet
    @birthday = Birthday.find params[:id]
    @planetary_card = @birthday.card_for_last_planet
    @planetary_card_explanation = @planetary_card.interpretations.where(:reading => :yearly).last&.explanation
    @alternative_planetary_card_location = this_planet_birthday_path(@birthday)
    @link_text = "What card do I have now?"
  end
  
  def this_planet
    @birthday = Birthday.find params[:id]
    @planetary_card = @birthday.card_for_this_52_day_period
    @planetary_card_explanation = @planetary_card.interpretations.where(:reading => :yearly).last&.explanation
    @alternative_planetary_card_location = last_planet_birthday_path(@birthday)
    @link_text = "What card did I have before this?"
    render :template => 'birthdays/last_planet.js.erb'
  end
  
  def create
    @birthday = Birthday.find_or_create_by :year => birthday_params['date(1i)'], :month => birthday_params['date(2i)'], :day => birthday_params['date(3i)']
    @lookup = Lookup.create :birthday => @birthday, :ip_address => request.remote_ip
    @birth_card = @birthday.birth_card
    @birth_card_explanation = @birth_card.interpretations.where(:reading => :birth).last&.explanation
    render :template => 'birthdays/member_form'
  end
  
  def birthday_params
    params.require(:birthday).permit('date(1i)', 'date(2i)', 'date(3i)')
  end
  
  def redirect_customer
    redirect_to :action => :new
  end
end
