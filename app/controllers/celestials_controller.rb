class CelestialsController < ApplicationController
  before_action :set_celestial, only: [:show, :edit, :update, :destroy]

  def index
    @celestials = Celestial.all
  end

  def show
  end

  def new
    @celestial = Celestial.new
  end

  def edit
  end

  def create
    @celestial = Celestial.new celestial_params
    @celestial.member = current_member

    respond_to do |format|
      if @celestial.save
        format.html { redirect_to @celestial, notice: 'Celestial was successfully created.' }
        format.json { render :show, status: :created, location: @celestial }
      else
        format.html { render :new }
        format.json { render json: @celestial.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @celestial.update celestial_params
        format.html { redirect_to @celestial, notice: 'Celestial was successfully updated.' }
        format.json { render :show, status: :ok, location: @celestial }
      else
        format.html { render :edit }
        format.json { render json: @celestial.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @celestial.destroy
    respond_to do |format|
      format.html { redirect_to celestials_url, notice: 'Celestial was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_celestial
      @celestial = Celestial.find params[:id]
    end

    def celestial_params
      params.require(:celestial).permit :birthday_id, :name
    end
end
