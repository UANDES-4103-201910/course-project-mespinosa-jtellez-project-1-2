class CreateGeofences < ActiveRecord::Migration[5.2]
  def change
    create_table :geofences do |t|
      t.string :location
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
