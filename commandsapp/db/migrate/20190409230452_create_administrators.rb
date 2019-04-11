class CreateAdministrators < ActiveRecord::Migration[5.2]
  def change
    create_table :administrators do |t|
      t.timestamp :last_access
      t.boolean :superadmin
      t.references :geofence
      t.references :user

      t.timestamps
    end
  end
end
