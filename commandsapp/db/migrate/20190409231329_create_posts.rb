class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.timestamp :creation_date
      t.text :description
      t.string :location
      t.decimal :latitude
      t.decimal :longitude
      t.string :country
      t.boolean :open
      t.boolean :solved
      t.references :user

      t.timestamps
    end
  end
end
