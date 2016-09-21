class CreateTravelClasses < ActiveRecord::Migration[5.0]
  def change
    create_table :travel_classes do |t|
      t.string :name
      t.decimal :tax_percent

      t.timestamps
    end
  end
end
