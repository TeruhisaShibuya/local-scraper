class CreateSites < ActiveRecord::Migration[5.1]
  def change
    create_table :sites do |t|
      t.string :name
      t.string :url
      t.string :crawl

      t.timestamps
    end
  end
end
