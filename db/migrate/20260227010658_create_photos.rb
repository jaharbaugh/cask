class CreatePhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :photos do |t|
      t.string  :name, null: false
      t.string  :photographer
      t.string  :url, null: false
      t.string  :source, null: false
      t.string  :license
      t.references  :cocktail, null: false, foreign_key: true
      t.timestamps
    end
  end
end
