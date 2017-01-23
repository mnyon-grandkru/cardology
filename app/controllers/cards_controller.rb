class CardsController < ApplicationController
  def index
    @cards = Card.all
  end
  
  def edit
    @card = Card.find params[:id]
  end
  
  def update
    @card = Card.find params[:id]
    @card.update_attributes card_params
    redirect_to :action => :index
  end
  
  protected
  
  def card_params
    params.require(:card).permit(:image)
  end
end
