class BirthdaysController < ApplicationController
  skip_before_action :verify_authenticity_token, :if => lambda { request.domain == 'lifeelevated.life' }
  before_action :redirect_customer, :only => :index
  
  def index
    @birthdays = Birthday.all
  end
  
  def show
    @member = current_member || Member.find(params[:member_id])
    @birthday = Birthday.find params[:id]
    @birth_card = @birthday.birth_card
    @birthday.zodiac_sign = @member&.zodiac_sign&.intern
    if @birthday.astrological_sign.is_cusp?
      @personality_card = nil
    else
      @personality_card = @birthday.personality_card
    end
    @yearly_card = @birthday.card_for_this_year
    @planetary_card = @birthday.card_for_this_planet
    @birth_card_explanation = @birth_card.interpretations.where(:reading => :birth).last&.explanation
    @personality_card_explanation = @personality_card&.interpretations&.where(:reading => :personality)&.last&.explanation
    @personality_card_explanation ||= @personality_card&.interpretations&.where(:reading => :birth)&.last&.explanation
    @yearly_card_explanation = @yearly_card.interpretations.where(:reading => :yearly).last&.explanation
    @planetary_card_explanation = @planetary_card.interpretations.where(:reading => :yearly).last&.explanation
    @scroll_to_top = params[:scroll_to_top]
  end
  
  def replace_card
    @birthday = Birthday.find params[:id]
    @card = case params[:reading_type]
    when 'last_year'
      @alternative_card_location = replace_card_birthday_path(@birthday, :reading_type => 'this_year')
      @header_text = 'Your Yearly Card'
      @header_subtitle = ENV['YEARLY_CARD_SUBTITLE']
      @link_text = "See This Year's Card"
      @structural_role = 'yearly_card_for'
      @birthday.card_for_last_year
    when 'this_year'
      @alternative_card_location = replace_card_birthday_path(@birthday, :reading_type => 'last_year')
      @header_text = 'Your Yearly Card'
      @header_subtitle = ENV['YEARLY_CARD_SUBTITLE']
      @link_text = "See Last Year's Card"
      @structural_role = 'yearly_card_for'
      @birthday.card_for_this_year
    when 'last_planet'
      @alternative_card_location = replace_card_birthday_path(@birthday, :reading_type => 'this_planet')
      @header_text = 'Your 52-Day Card'
      @header_subtitle = ENV['PLANETARY_CARD_SUBTITLE']
      @link_text = "What card do I have now?"
      @structural_role = 'planetary_card_for'
      @birthday.card_for_last_planet
    when 'this_planet'
      @alternative_card_location = replace_card_birthday_path(@birthday, :reading_type => 'last_planet')
      @header_text = 'Your 52-Day Card'
      @header_subtitle = ENV['PLANETARY_CARD_SUBTITLE']
      @link_text = "What card did I have before this?"
      @structural_role = 'planetary_card_for'
      @birthday.card_for_this_planet
    end
    @card_explanation = @card.interpretations.where(:reading => :yearly).last&.explanation
    render :template => 'birthdays/replace_card.js.erb'
  end
  
  def new
    if current_member
      @goal = 'Look Up Another Birth Card'
      @instructions = 'Enter the Birthdate'
    else
      @goal = 'Find Out Your Birth Card'
      @instructions = 'Enter your Date of Birth:'
    end
  end
  
  def mine
    redirect_to current_member.birthday
  end
  
  def create
    @birthday = Birthday.find_or_create_by :year => birthday_params['date(1i)'], :month => birthday_params['date(2i)'], :day => birthday_params['date(3i)']
    @lookup = Lookup.create :birthday => @birthday, :ip_address => request.remote_ip
    @birth_card = @birthday.birth_card
    @birth_card_explanation = @birth_card.interpretations.where(:reading => :birth).last&.explanation
    if current_member
      render :template => 'birthdays/birth_card'
    else
      render :template => 'birthdays/member_form'
    end
  end
  
  def second_try
    @goal = 'Find Out Your Birth Card'
    @instructions = 'Enter your Date of Birth:'
    @email = params[:member][:email]
    @password_explanation = "Oops, it looks like you're entering the wrong password.<br>The temporary password was emailed to you when you signed up.<br>Please check your email for the password.".html_safe
    render 'new.html.erb'
  end
  
  def birthday_params
    params.require(:birthday).permit('date(1i)', 'date(2i)', 'date(3i)')
  end
  
  def redirect_customer
    redirect_to :action => :new
  end
end
