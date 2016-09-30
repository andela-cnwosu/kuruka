# frozen_string_literal: true
class CreateFlights < ActiveRecord::Migration[5.0]
  def change
    create_table :flights do |t|
      t.datetime :departure_date
      t.datetime :arrival_date
      t.references :aircraft, foreign_key: true
      t.references :route, foreign_key: true

      t.timestamps
    end
  end
end
