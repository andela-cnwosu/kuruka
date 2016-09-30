# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Booking, type: :model do
  let(:user) do
    {
      first_name: 'Chinese',
      last_name: 'Benny',
      email: 'user@gmail.com',
      password: 'password'
    }
  end

  before do
    create :airport
    create :route
    create :flight
    @booking = create(:booking, user: nil)
  end

  describe '#has_many' do
    it 'has many passengers' do
      expect(@booking).to have_many(:passengers)
    end
  end

  describe '#has_one' do
    it 'has one payment' do
      expect(@booking).to have_one(:payment)
    end
  end

  describe '#belongs_to' do
    it 'belongs to a flight' do
      expect(@booking).to belong_to(:flight)
    end
  end

  describe '#belongs_to' do
    it 'belongs to a user' do
      expect(@booking).to belong_to(:user)
    end
  end

  describe '#accepts_nested_attributes_for' do
    it 'accepts nested attributes for passengers' do
      expect(@booking).to accept_nested_attributes_for(:passengers)
    end
  end

  describe '#departure' do
    it 'returns the departure city for flight' do
      expect(@booking.departure).to eql('Abuja')
    end
  end

  describe '#arrival' do
    it 'returns the arrival city for flight' do
      expect(@booking.arrival).to eql('Abuja')
    end
  end

  describe '#departure_date' do
    it 'returns the departure date for flight' do
      date = Time.zone.now + 86_400
      expect(@booking.departure_date.strftime('%Y-%m-%d'))
        .to eql(date.strftime('%Y-%m-%d'))
    end
  end

  describe '#route_name' do
    it 'returns the route name for flight' do
      expect(@booking.route_name).to eql('Abuja to Abuja')
    end
  end

  describe '#passengers_names' do
    it 'returns the names of passengers on a flight' do
      @passenger = create :passenger, booking: @booking
      expect(@booking.passengers_names).to eql('Chineze Nwosu')
    end
  end

  describe '#set_total_cost' do
    it 'returns the total cost of a booking' do
      passenger = create :passenger
      @booking.passengers = [passenger]
      @booking.set_total_cost
      @booking.save
      expect(@booking.cost_in_dollar).to eql(1100.0)
    end
  end

  describe '#decorated_flight' do
    it 'returns a flight decorator as a booking property' do
      @flight = @booking.decorated_flight
      expect(@flight).to respond_to(:pastize)
    end
  end

  describe '#user_email' do
    context 'when user is registered' do
      it 'returns the email of the user' do
        @booking.user = User.create(user)
        expect(@booking.user_email).to eql('user@gmail.com')
      end
    end

    context 'when user is anonymous' do
      it 'returns the email of the passenger' do
        expect(@booking.user_email).to eql('passenger@gmail.com')
      end
    end
  end

  describe '#user_first_name' do
    context 'when user is registered' do
      it 'returns the first name of the user' do
        @booking.user = User.create(user)
        expect(@booking.user_first_name).to eql('Chinese')
      end
    end

    context 'when user is anonymous' do
      it 'returns the user name of the email address' do
        @booking.user = @user
        expect(@booking.user_first_name).to eql('passenger')
      end
    end
  end
end
