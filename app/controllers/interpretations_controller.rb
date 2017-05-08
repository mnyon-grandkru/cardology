class InterpretationsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @interpretations = if params[:by_face]
      Interpretation.by_face
    elsif params[:suit] && params[:reading]
      Interpretation.order(params[:sort]).of_suit(params[:suit]).of_reading(params[:reading])
    elsif params[:suit]
      Interpretation.order(params[:sort]).of_suit(params[:suit])
    elsif params[:reading]
      Interpretation.order(params[:sort]).of_reading(params[:reading])
    else
      Interpretation.order(params[:sort])
    end.page(params[:page])
  end
  
  def ids
    @interpretation_ids = Interpretation.all.map(&:id)
    render :json => @interpretation_ids
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
