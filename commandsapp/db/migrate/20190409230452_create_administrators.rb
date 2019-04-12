class CreateAdministrators < ActiveRecord::Migration[5.2]
  def change
    create_table :administrators do |t|
      t.timestamp :last_access
      t.boolean :superadmin
      t.reference :geofence
      t.reference :user

      t.timestamps
    end
  end
end
