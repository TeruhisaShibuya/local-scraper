class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :item_url
      t.string :image_url
      t.string :brands

      t.timestamps
    end
  end
end
