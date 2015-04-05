class CreateFavoritePages < ActiveRecord::Migration
  def change
    create_table :favorite_pages do |t|
      t.string :url_digest
      t.text :url
      t.text :title
      t.text :description
      t.text :keywords, array: true, default: [], null: false
      t.text :content

      t.timestamps null: false
    end
    add_index :favorite_pages, :url_digest, unique: true
  end
end
