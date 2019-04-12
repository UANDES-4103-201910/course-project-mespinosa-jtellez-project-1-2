class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.reference :user
      t.reference :post

      t.timestamps
    end
  end
end
