class BirthdaysController < ApplicationController
  def index
    @birthdays = Birthday.all
  end
  
  def show
    @birthday = Birthday.find params[:id]
    @birth_card = @birthday.birth_card
    @personality_card = @birthday.personality_card
    @yearly_card = @birthday.card_for_this_year
    @planetary_card = @birthday.card_for_this_52_day_period
    @birth_card_explanation = @birth_card.interpretations.where(:reading => :birth).last&.explanation || Interpretation.last&.explanation
    @personality_card_explanation = @personality_card.interpretations.where(:reading => :birth).last&.explanation || Interpretation.last&.explanation
    @yearly_card_explanation = @yearly_card.interpretations.where(:reading => :yearly).last&.explanation || Interpretation.last&.explanation
    @planetary_card_explanation = @planetary_card.interpretations.where(:reading => :yearly).last&.explanation || Interpretation.last&.explanation
  end
  
  def create
    @birthday = Birthday.find_or_create_by :year => birthday_params['date(1i)'], :month => birthday_params['date(2i)'], :day => birthday_params['date(3i)']
    @lookup = Lookup.create :birthday => @birthday, :ip_address => request.remote_ip
    render :template => 'birthdays/member_form'
    # redirect_to @birthday
  end
  
  def birthday_params
    params.require(:birthday).permit('date(1i)', 'date(2i)', 'date(3i)')
  end
end
