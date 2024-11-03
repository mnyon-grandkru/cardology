class GuidancesController < ApplicationController
  # skip_before_action :verify_authenticity_token, :if => lambda { ['lifeelevated.life', 'thesourcecards.com', 'herokuapp.com' , 'blueprint.thesourcecards.com', 'thecardsoflife.com'].include? request.domain }
  skip_before_action :verify_authenticity_token
  before_action :purchaser
  
  ## Subscriber Interface
  
  def prompt
    @date = rand((50.years.ago)..20.years.ago)
  end
  
  def show
    redirect_back(fallback_location: "#{params[:prompt].present?? "/guidances/prompt" : "/guidances/lookup_cards"}") and return if params['birthday'].blank? && params['birthday_id'].blank?
    if params['birthday_id']
      @birthday = Birthday.find params[:birthday_id]
    else
      @birthday = Birthday.find_or_create_by :year => params['birthday']['date(1i)'], :month => params['birthday']['date(2i)'], :day => params['birthday']['date(3i)']
    end

    @planet = @birthday.current_planet_sym
    @sequence = 7

    @lookup = Lookup.create :birthday => @birthday, :ip_address => request.remote_ip
    if params[:reading_type] == 'Personality Card'
      @birthday.zodiac_sign = params[:zodiac] if params[:zodiac]
      if @birthday.astrological_sign.is_cusp?
        render :template => 'guidances/pick_zodiac.js'
      else
        render :js => "window.location = '/guidances/personality?birthday_id=#{@birthday.id}'"
        # render :template => 'guidances/show', :locals => {personality: true, zodiac: params[:zodiac]}
      end
    else
      @main_card = @birthday.birth_card
      render :template => 'guidances/card_box'
    end
  end

  def personality
    @birthday = Birthday.find params[:birthday_id]
    @personality = true
    @zodiac = params[:zodiac]&.to_sym
    @birthday.zodiac_sign = @zodiac if @zodiac
    @main_card = @birthday.personality_card
    @planet = @birthday.current_planet_sym
    @sequence = 7
    render :template => 'guidances/card_box'#, :locals => {personality: true, zodiac: params[:zodiac]}
  end

  def planet_card
    @birthday = Birthday.find params[:birthday_id]
    @personality = params[:personality]
    @zodiac = params[:zodiac]&.to_sym
    if @personality
      @birthday.zodiac_sign = @zodiac if @zodiac
      @main_card = @birthday.personality_card
    else
      @main_card = @birthday.birth_card
    end

    #days since birthday
    @days_since_birthday = @birthday.days_since_birthday
    lived_sequence = @days_since_birthday / 52
    sequence = params[:sequence].to_i.abs
    Rails.logger.info "lived sequence: #{lived_sequence}, sequence: #{sequence}"
    if (7 - lived_sequence) >= sequence
      Rails.logger.info "previous year"
      @year = @birthday.previous_birthday
    elsif (7 - lived_sequence) < (sequence - 7)
      Rails.logger.info "next year"
      @year = @birthday.next_birthday
    else
      Rails.logger.info "current year"
      @year = @birthday.last_birthday
    end

    if params[:sequence].to_i >= 0
      @planet = @birthday.upcoming_planet_sym params[:planet].to_sym
      @card = @birthday.card_for_upcoming_planet @main_card, @planet, @year
      @date = @birthday.conclusion_of_upcoming params[:planet].to_sym, @year
      @sequence = sequence + 1
      @frame = frame_for @sequence
    else
      @planet = @birthday.previous_planet_sym params[:planet].to_sym
      @card = @birthday.card_for_previous_planet @main_card, @planet, @year
      @date = @birthday.conclusion_of_previous params[:planet].to_sym, @year
      @sequence = sequence - 1
      
      @frame = frame_for @sequence
    end
    render :template => 'guidances/card52', :format => :js
  end
  
  ## Card-Box Interface
  
  def card_box
    @birthday = Birthday.find 1
    @main_card = @birthday.birth_card
    @reading = 'daily'
  end

  def octagon
    @birthday = Birthday.find 1
    @main_card = @birthday.birth_card
    @reading = 'daily'
  end
  
  ## Simplero-bound purchaser interface
  
  def choose_date
    @source = 'Simplero'
    @date = rand((50.years.ago)..20.years.ago)
  end
  
  def receive_reading
    @birthday = Birthday.find_or_create_by :year => params['birthday']['date(1i)'], :month => params['birthday']['date(2i)'], :day => params['birthday']['date(3i)']
    @lookup = Lookup.create :birthday => @birthday, :ip_address => request.remote_ip
    @main_card = @birthday.birth_card
  end
  
  ## Purchaser Interface

  def initialize_payment
    redirect_to guidances_lookup_cards_path(source: 'cookie') if purchaser
    @source_website = params[:source] || "please enter source in query params"
    @client_token = Braintree::ClientToken.generate
  end

  def payment
    @source = params[:source_website]  || "please enter source in query params"
    result = Braintree::Transaction.sale(
      amount: "7.00",
      payment_method_nonce: params[:nonce],
      :billing => {
        :company => @source},
      options: {
        submit_for_settlement: true
      }
    )
    if result.success?
      flash[:success] = "Payment Successful. Check your fortune!"
      cookies['transaction_token'] = ENV['transaction_token'] = SecureRandom.hex(16)
      cookies['transaction_time'] = DateTime.now.to_s
      redirect_to guidances_lookup_cards_path(source: @source)
    else
      flash[:error] = "Payment failed. Please try again."
      redirect_to guidances_initialize_payment_path
    end
  end
  
  def lookup_cards
    @source = params[:source]
    Rails.logger.info "Cookies for transaction: #{cookies['transaction_token']} #{cookies['transaction_time']}"
    # redirect_to guidances_initialize_payment_path unless purchaser
    @date = rand((50.years.ago)..20.years.ago)
  end
  
  def flip_cards
    @birthday = Birthday.find_or_create_by :year => params['birthday']['date(1i)'], :month => params['birthday']['date(2i)'], :day => params['birthday']['date(3i)']
    @main_card = @birthday.birth_card
    @lookup = Lookup.create :birthday => @birthday, :ip_address => request.remote_ip
  end
  
  def staging_payment
    cookies['transaction_token'] = ENV['transaction_token'] = SecureRandom.hex(16)
    cookies['transaction_time'] = DateTime.now.to_s
    redirect_to guidances_lookup_cards_path(source: 'staging')
  end

  def daily_card
    @birthday = Birthday.find params[:birthday_id]
    @birthday.zodiac_sign = params[:zodiac].to_sym if params[:zodiac]
    @main_card = params[:personality] ? @birthday.personality_card : @birthday.birth_card

    if params[:day] == 'yesterday'
      @header = 'yesterday'
      @card = @birthday.card_for_yesterday @main_card
      @date = DateTime.yesterday
    elsif params[:day] == 'tomorrow'
      @card = @birthday.card_for_tomorrow @main_card
      @header = 'tomorrow'
      @date = DateTime.tomorrow
    else
      @card = @birthday.card_for_today @main_card
      @header = 'daily'
      @date = Date.current
    end
  end
  
  def card52
    @birthday = Birthday.find params[:birthday_id]
    @birthday.zodiac_sign = params[:zodiac].to_sym if params[:zodiac]
    @main_card = params[:personality] ? @birthday.personality_card : @birthday.birth_card
    
    if params[:planet] == 'current'
      @card = @birthday.card_for_this_planet @main_card
      @planet = @birthday.current_planet
      @date = @birthday.date_of_next_planet
    elsif params[:planet] == 'last'
      @card = @birthday.card_for_last_planet @main_card
      @planet = @birthday.last_planet
      @date = @birthday.date_of_next_planet  - 52.days
    elsif params[:planet] == 'next'
      @card = @birthday.card_for_next_planet @main_card
      @planet = @birthday.next_planet
      @date = @birthday.date_of_next_planet  + 52.days
    end
  end
  
  def planet
    @face = {'here' => '.gamma', 'back' => '.beta', 'forward' => '.delta'}[params[:position]]
  end

  def year_card
    @birthday = Birthday.find params[:birthday_id]
    @birthday.zodiac_sign = params[:zodiac].to_sym if params[:zodiac]
    @main_card = params[:personality] ? @birthday.personality_card : @birthday.birth_card
    
    if params[:year] == 'current'
      @card = @birthday.card_for_this_year @main_card
    elsif params[:year] == 'last'
      @card = @birthday.card_for_last_year @main_card
    elsif params[:year] == 'next'
      @card = @birthday.card_for_next_year @main_card
    end
  end
  
  def purchaser
    @purchase = cookies['transaction_time'].present? && (DateTime.now - DateTime.parse(cookies['transaction_time'])) < 1
  end

  def frame_for sequence
    ['delta','alpha', 'beta', 'gamma'][sequence.abs % 4]
  end
end
