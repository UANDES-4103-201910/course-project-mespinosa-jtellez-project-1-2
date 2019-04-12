class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.binary :picture
      t.text :biography
      t.string :city
      t.string :country
      t.reference :user

      t.timestamps
    end
  end
end
