# frozen_string_literal: true
class CreateAircrafts < ActiveRecord::Migration[5.0]
  def change
    create_table :aircrafts do |t|
      t.string :tail_number
      t.integer :economy_capacity
      t.integer :business_capacity
      t.integer :first_capacity

      t.timestamps
    end
  end
end
