# frozen_string_literal: true
class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.string :booking_ref
      t.decimal :cost_in_dollar
      t.string :passenger_email
      t.references :user, foreign_key: true
      t.references :flight, foreign_key: true

      t.timestamps
    end
  end
end
