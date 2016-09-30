# frozen_string_literal: true
class CreatePassengers < ActiveRecord::Migration[5.0]
  def change
    create_table :passengers do |t|
      t.string :first_name, limit: 30
      t.string :last_name, limit: 30
      t.string :phone, limit: 16
      t.string :passport_no, limit: 15
      t.boolean :checked_in, default: false
      t.references :user, foreign_key: true
      t.references :airfare, foreign_key: true
      t.references :booking, foreign_key: true

      t.timestamps
    end
  end
end
