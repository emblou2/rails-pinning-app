class PinsController < ApplicationController
  
  def index
    @pins = Pin.all
  end

   def show_by_name
    @pin = Pin.find_by_slug(params[:slug])
    render :show
  end

  
  def show
    @pin = Pin.find(params[:id])
  end

   def new
    @pin = Pin.new
  end

  def create
    @pin = Pin.new(pin_params)
    if @pin.valid?
      @pin.save
      redirect_to "/pins/name-#{@pin.slug}"
    else
      @errors = @pin.errors
      render :new
    end
  end


  private
  def pin_params
    params.require(:pin).permit(:title, :url, :text, :slug, :category_id)
  end
end
  