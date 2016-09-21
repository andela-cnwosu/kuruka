class CreateRoutes < ActiveRecord::Migration[5.0]
  def change
    create_table :routes do |t|
      t.string :name
      t.references :departure_airport
      t.references :arrival_airport

      t.timestamps
    end
  end
end
