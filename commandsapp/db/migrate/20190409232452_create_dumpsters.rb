class CreateDumpsters < ActiveRecord::Migration[5.2]
  def change
    create_table :dumpsters do |t|
      t.references :post
      t.timestamp :date

      t.timestamps
    end
  end
end
