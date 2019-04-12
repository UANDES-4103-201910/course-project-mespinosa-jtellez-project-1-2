class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.reference :user
      t.reference :post
      t.integer :value

      t.timestamps
    end
  end
end
