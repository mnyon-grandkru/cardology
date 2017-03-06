class InterpretationsController < ApplicationController
  def index
    @interpretations = if params[:by_face]
      Interpretation.by_face
    elsif params[:suit]
      Interpretation.order(params[:sort]).of_suit(params[:suit])
    else
      Interpretation.order(params[:sort])
    end
  end
  
  def show
    @interpretation = Interpretation.find params[:id]
    render :json => @interpretation
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
