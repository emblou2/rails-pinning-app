require 'spec_helper'

RSpec.describe PinsController do
   describe "GET index" do
 
      it 'renders the index template' do
        get :index
        expect(response).to render_template(:index)
      end 
    
  it 'populates @pins with all pins' do
    get :index
    expect(assigns[:pins]).to eq(Pin.all)
  end
end
describe "GET new" do
    it 'responds with successfully' do
      get :new
      expect(response.success?).to be(true)
    end
    
    it 'renders the new view' do
      get :new      
      expect(response).to render_template(:new)
    end
    
    it 'assigns an instance variable to a new pin' do
      get :new
      expect(assigns(:pin)).to be_a_new(Pin)
    end
  end
  
  describe "POST create" do
    before(:each) do
      @pin_hash = { 
        title: "Rails Wizard", 
        url: "http://railswizard.org", 
        slug: "rails-wizard", 
        text: "A fun and helpful Rails Resource",
        category_id: "2"}    
    end
    
    after(:each) do
      pin = Pin.find_by_slug("rails-wizard")
      if !pin.nil?
        pin.destroy
      end
    end
    
    it 'responds with a redirect' do
      post :create, pin: @pin_hash
      expect(response.redirect?).to be(true)
    end
    
    it 'creates a pin' do
      post :create, pin: @pin_hash  
      expect(Pin.find_by_slug("rails-wizard").present?).to be(true)
    end
    
    it 'redirects to the show view' do
      post :create, pin: @pin_hash
      expect(response).to redirect_to(pin_url(assigns(:pin)))
    end
    
    it 'redisplays new form on error' do
      # The title is required in the Pin model, so we'll
      # delete the title from the @pin_hash in order
      # to test what happens with invalid parameters
      @pin_hash.delete(:title)
      post :create, pin: @pin_hash
      expect(response).to render_template(:new)
    end
    
    it 'assigns the @errors instance variable on error' do
      # The title is required in the Pin model, so we'll
      # delete the title from the @pin_hash in order
      # to test what happens with invalid parameters
      @pin_hash.delete(:title)
      post :create, pin: @pin_hash
      expect(assigns[:errors].present?).to be(true)
    end    
    
  end
  describe "GET edit" do
  
    before(:each) do
      @pin_hash = { 
        title: "Rails Wizard", 
        url: "http://railswizard.org", 
        slug: "rails-wizard", 
        text: "A fun and helpful Rails Resource",
        category_id: "2"}    
    end
    
    after(:each) do
      pin = Pin.find_by_slug("rails-wizard")
      if !pin.nil?
        pin.destroy
      end
    end
    #get to pin/id/edit
  #responds successfully
  it 'responds with successfully' do
    get :edit, id: @pin_hash
    expect(response.success?).to be(true)
  end
  #renders the edit template
  it 'renders the edit view' do
    get :edit, id: @pin_hash
    expect(response).to render_template(:edit)
  end
  #assigns an instance variable called @pin to the Pin with the appropriate id
  it 'assigns an instance variable to the appropriate pin' do
    get :edit, id: @pin_hash
    expect(assigns(:pin)).to eq(Pin.fin_by_slug(@pin_hash[:slug]))
  end
end
  describe "PUT update" do
  
  before(:each) do
      @pin_hash = { 
        title: "Rails Wizard", 
        url: "http://railswizard.org", 
        slug: "rails-wizard", 
        text: "A fun and helpful Rails Resource",
        category_id: "2"}    
    
    @pin = Pin.create(
      title: "Rails Wizard", 
        url: "http://railswizard.org", 
        slug: "rails-wizard", 
        text: "A fun and helpful Rails Resource",
        category_id: "2")
    end
    after(:each) do
      pin = Pin.find_by_slug("rails-wizard")
      if !pin.nil?
        pin.destroy
      end
    end
  
  it 'responds with successfully' do
    put :update, pin: @pin_hash, id: @pin
    expect(repsonse.redirect?).to be(true)
  end
  
  it 'updates a pin' do
    @pin_hash[:title] = "test"
    put :update, pin: @pin_hash, id: @pin
    expect(assigns(:pin)[:title]).to eq(@pin_hash[:title])
  end
  
  it 'redirects to show view' do
    put :update, pin: @pin_hash, id: @pin
    expect(response).to redirect_to(pin_url(assigns(:pin)))
  end
  
  it 'assigns the @errors instance variable on error' do
    @pin_hash[:title] = ""
    put :update, pin: @pin_hash, id: @pin
    expect(assigns[:errors].present?).to be(true)
  end
  
  it 'renders edit when there is an error' do
    @pin_hash[:title] = ""
    put :update, pin: @pin_hash, id: @pin
    expect(response).to render_template(:edit)
  end
  end
end