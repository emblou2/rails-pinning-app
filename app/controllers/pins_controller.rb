class PinsController < ApplicationController
  
  def index
    @pins = Pin.all
  end

  def show
    #@pin = Pin.find(pin_params)
    @pin = Pin.find(params[:id])
  end


  # Search for a Pin using the slug in the URL
  def show_by_name
    @pin = Pin.find_by_slug(params[:slug])
    render :show
  end

  # GET /pins/1/edit
  def edit
    @pin = Pin.find(params[:id])
    render :edit
    #edit_pin_path
  end

  #Method to update a pin record
  def update

    @pin = Pin.find(params[:id])
    if @pin.update_attributes(pin_params)
      @pin.title = params[:title]
      @pin.url = params[:url]
      @pin.text = params[:text]
      @pin.slug = params[:slug]
      @pin.category_id = params[:category_id]
      @pin.image = params[:image]
      redirect_to pin_path(@pin)
    else
      @pin.errors.full_messages.each do |msg|
      @errors = "#{@errors} #{msg}."
      end
      render :edit
    end

   # if @pin.valid?
    #  @pin.save
     # redirect edit_pin_path(@pin)
    #else
     # @pin.errors.full_messages.each do |msg|
      #  @errors = "#{@errors} #{msg}."
      #end
      #render :edit   
    #end
  end

# GET /pins/new
  def new
    @pin = Pin.new
    #new_pin_path
  end
  
  # Create a new pin
  def create
    @pin = Pin.create(pin_params)
    #@pin = Pin.create(params[:pin])
    if @pin.valid?
      @pin.save
      redirect_to pin_path(@pin)
    else
      @errors = @pin.errors
      render :new
    end
  end
  
    private
    def pin_params
      params.require(:pin).permit(:title, :url, :slug, :text, :category_id, :image)
    end

  
end