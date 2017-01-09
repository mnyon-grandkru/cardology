class InterpretationsController < ApplicationController
  def index
    @interpretations = Interpretation.all
  end
  
  def show
    
  end
  
  def new
    @interpretation = Interpretation.new
  end
  
  def create
    @interpretation = Interpretation.create interpretation_params
    redirect_to :action => :index
  end
  
  def edit
    @interpretation = Interpretation.find params[:id]
  end
  
  def update
    @interpretation = Interpretation.find params[:id]
    @interpretation.update_attributes interpretation_params
    redirect_to :action => :index
  end
  
  def interpretation_params
    params.require(:interpretation).permit(:reading, :explanation, :card_id)
  end
end
