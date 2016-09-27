require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  let(:new_booking) do
    {
      flight_id: Flight.first.id,
      passenger_email: Faker::Internet.email,
      passengers_attributes: [{ 
        first_name: "Chinese",
        last_name: "Benny",
        phone: "08012345678",
        airfare_id: 1
      }]
    }
  end

  before do
    load "#{Rails.root}/spec/support/seed.rb"
    Seed.create_models
  end

  describe "GET #index" do
    context "when a user is registered" do
      before do
        session[:user_id] = 1
      end

      it "returns a status of 200" do
        get :index
        expect(controller).to respond_with :ok
      end

      it "returns all the bookings made by the user" do
        booking = create :booking, user: User.first
        get :index
        expect(response.body).to include booking.booking_ref
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template :index
      end

      it "shows the pagination div on page" do
        bookings = []
        user = User.first
        params = { user: user, passenger_email: Faker::Internet.email }
        20.times do |number|
          bookings << create(:booking, params)
        end
        get :index
        expect(response.body).to have_selector 'div.pagination'
      end
    end

    context "when a user is anonymous" do
      it "returns a redirect to the home page" do
        get :index
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "POST #select" do
    context "when a flight is selected" do
      it "returns a redirect to the new bookings page" do
        post :select
        expect(response).to redirect_to new_booking_path
      end
    end
  end

  describe "GET #new" do
    before do
      flight = Flight.first
      get :new, params: { flight: flight }
    end

    it "renders the new template" do
      expect(response).to render_template :new
    end

    it "returns a status of 200" do
      expect(controller).to respond_with :ok
    end
  end

  describe "POST #retrieve" do
    it "returns a status of 200" do
      get :manage
      expect(controller).to respond_with :ok
    end
  end

  describe "POST #create" do
    it "returns a status of 302" do
      flight = Flight.first
      get :new, params: { flight: flight }
      post :create, params: { booking: new_booking }
      expect(controller).to respond_with 302
    end
  end

  describe "PUT #update" do
    before do
      @my_booking = create :booking
      new_booking[:passengers_attributes] << {
        first_name: "China",
        last_name: "Ben",
        phone: "09000000000",
        airfare_id: 2
      }
      put :update, params: { id: @my_booking.id, booking: new_booking }
    end

    it "assigns the requested booking as @my_booking" do
      expect(assigns(:booking)).to eq(@my_booking)
    end

    it "returns a status of 302" do
      expect(controller).to respond_with 302
    end

    it "redirects back to edit booking page" do
      expect(response).to redirect_to(edit_booking_path)
    end
  end

  describe "DELETE #destroy" do
    before do
      session[:user_id] = 1
      @booking = create :booking
    end

    it "destroys the requested booking" do
      expect { delete :destroy, params: { id: @booking.id } }.
        to change(Booking, :count).by(-1)
    end

    it "redirects to the bookings list" do
      delete :destroy, params: { id: @booking.id }
      expect(response).to redirect_to(bookings_path)
    end
  end
end
