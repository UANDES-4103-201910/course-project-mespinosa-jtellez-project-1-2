class CreateAttacheds < ActiveRecord::Migration[5.2]
  def change
    create_table :attacheds do |t|
      t.string :name
      t.binary :content
      t.references :post

      t.timestamps
    end
  end
end
