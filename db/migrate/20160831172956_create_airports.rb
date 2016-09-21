class CreateAirports < ActiveRecord::Migration[5.0]
  def change
    create_table :airports do |t|
      t.string :name
      t.string :city
      t.string :iata_code
      t.references :state, foreign_key: true

      t.timestamps
    end
  end
end
