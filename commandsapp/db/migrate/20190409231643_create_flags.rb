class CreateFlags < ActiveRecord::Migration[5.2]
  def change
    create_table :flags do |t|
      t.references :user
      t.references :post
      t.text :comment

      t.timestamps
    end
  end
end
