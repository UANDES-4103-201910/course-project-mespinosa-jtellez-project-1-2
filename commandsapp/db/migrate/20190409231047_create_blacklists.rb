class CreateBlacklists < ActiveRecord::Migration[5.2]
  def change
    create_table :blacklists do |t|
      t.timestamp :date
      t.references :user

      t.timestamps
    end
  end
end
