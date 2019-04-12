class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.reference :user
      t.reference :post

      t.timestamps
    end
  end
end
