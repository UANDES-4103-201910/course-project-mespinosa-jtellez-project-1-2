class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :password
      t.string :name
      t.integer :role
      t.string :provider
      t.string :uid
      t.datetime :lastAccess

      t.timestamps
    end
  end
end
