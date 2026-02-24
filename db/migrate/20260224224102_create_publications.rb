class CreatePublications < ActiveRecord::Migration[7.1]
  def change
    create_table :publications do |t|
      t.string  :title, null: false
      t.string  :author
      t.integer    :publication_type, null: false
      t.integer     :publication_year
      t.timestamps
    end
    
    add_index :publications, :publication_type
    add_index :publications, :publication_year
  end
end
