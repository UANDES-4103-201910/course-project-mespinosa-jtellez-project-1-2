class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.string :URL
      t.integer :start
      t.integer :end
      t.reference :post

      t.timestamps
    end
  end
end
