class GuidancesController < ApplicationController
  # skip_before_action :verify_authenticity_token, :if => lambda { ['lifeelevated.life', 'thesourcecards.com', 'herokuapp.com' , 'blueprint.thesourcecards.com', 'thecardsoflife.com'].include? request.domain }
  skip_before_action :verify_authenticity_token
  def prompt
    @date = rand((50.years.ago)..20.years.ago)
  end

  def lookup_cards
    @source = params[:source]
    redirect_to guidances_initialize_payment_path if ENV['transaction_token'].blank?
    @date = rand((50.years.ago)..20.years.ago)
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
      ENV['transaction_token'] = SecureRandom.hex(16)
      redirect_to guidances_lookup_cards_path(source: @source)
    else
      flash[:error] = "Payment failed. Please try again."
      redirect_to guidances_initialize_payment_path
    end
  end

  def initialize_payment
    @source_website = params[:source] || "please enter source in query params"
    @client_token = Braintree::ClientToken.generate
  end

  def show
    @show = params[:show]
    redirect_back(fallback_location: "#{params[:prompt].present?? "/guidances/prompt" : "/guidances/lookup_cards"}") and return if params['birthday'].blank?
    @birthday = Birthday.find_or_create_by :year => params['birthday']['date(1i)'], :month => params['birthday']['date(2i)'], :day => params['birthday']['date(3i)']
    @@birthdate = @birthday.id
    @lookup = Lookup.create :birthday => @birthday, :ip_address => request.remote_ip
    ENV.delete('transaction_token')
  end

  def daily_card
    @birthday = Birthday.find(@@birthdate)

    if params[:day] == 'yesterday'
      @header = 'yesterday'
      @card = @birthday.card_for_yesterday
      @date = DateTime.yesterday
    elsif params[:day] == 'tomorrow'
      @card = @birthday.card_for_tomorrow
      @header = 'tomorrow'
      @date = DateTime.tomorrow
    else
      @card = @birthday.card_for_today
      @header = 'daily'
      @date = Date.current
    end

  end
  def card52
    @birthday = Birthday.find(@@birthdate)
    if params[:planet] == 'current'
      @card = @birthday.card_for_this_planet
      @planet =@birthday.current_planet
      @date = @birthday.date_of_next_planet
    elsif params[:planet] == 'last'
      @card = @birthday.card_for_last_planet
      @planet =@birthday.last_planet
      @date = @birthday.date_of_next_planet  - 52.days
    elsif params[:planet] == 'next'
      @card = @birthday.card_for_next_planet
      @planet =@birthday.next_planet
      @date = @birthday.date_of_next_planet  + 52.days
    end

  end

  def year_card
    @birthday = Birthday.find(@@birthdate)
    if params[:year] == 'current'
      @card = @birthday.card_for_this_year
    elsif params[:year] == 'last'
      @card = @birthday.card_for_last_year
    elsif params[:year] == 'next'
      @card = @birthday.card_for_next_year
    end

  end

end
