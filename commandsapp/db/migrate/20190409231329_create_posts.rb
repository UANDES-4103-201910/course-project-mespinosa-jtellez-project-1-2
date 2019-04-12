class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.timestamp :creation_date
      t.text :description
      t.string :location
      t.boolean :open
      t.boolean :solved
      t.reference :user

      t.timestamps
    end
  end
end
