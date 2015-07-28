require 'spec_helper'

RSpec.describe PinsController do

  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "populates @pins with all pins" do
      get :index
      expect(assigns[:pins]).to eq(Pin.all)
    end
  end

  describe "GET new" do
    it "responds with success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "gives a new Pin record" do
      get :new
      expect(assigns[:pin]).to be_a_new(Pin)
    end
  end

  describe "create" do

    context "with valid attributes" do
      valid_attributes = { title: "Some title", url: "http://someurl.com",
          text: "Some text", slug: "some-slug", category_id: 1 }

      after(:each) do
        pin = Pin.find_by_slug("some-slug")
        if !pin.nil?
          pin.destroy
        end
      end

      it "should be valid" do
        pin = Pin.new(valid_attributes)
        expect(pin).to be_valid
      end

      it "saves the new pin in the database" do
        expect {
          post :create, pin: valid_attributes
        }.to change(Pin, :count).by(1)
      end

      it "redirects to the pin's page" do
        post :create, pin: valid_attributes
        expect(response.redirect?).to be(true)
      end

      it "does not have any errors" do
        post :create, pin: valid_attributes
        expect(assigns[:errors]).to be_nil
      end
    end

    context "with invalid attributes" do
      invalid_attributes = { some_attribute: "derp" }

      it "does not save the new pin in the database" do
        expect {
          post :create, pin: invalid_attributes
        }.to_not change(Pin, :count)
      end

      it "renders the new template" do
        post :create, pin: invalid_attributes
        expect(response).to render_template(:new)
      end

      it "renders the new template with errors" do
        post :create, pin: invalid_attributes
        expect(assigns[:errors]).to_not be_nil
      end
    end
  end

  describe "GET edit" do
    pin = Pin.first
    it "responds with success" do
      get :edit, id: pin.id
      expect(response).to have_http_status(:success)
    end

    it "renders the edit template" do
      get :edit, id: pin.id
      expect(response).to render_template(:edit)
    end

    it "assigns an instance variable called @pin to the Pin with the appropriate id" do
      get :edit, id: pin.id
      expect(assigns[:pin]).to eq(Pin.find(pin.id))
    end
  end

  describe "update" do

  end
end