class CreateCocktails < ActiveRecord::Migration[7.1]
  def change
    create_table :cocktails do |t|
      t.string  :name, null: false
      t.integer    :base_spirit, null: false
      t.references  :publication, null: false, foreign_key: true 
      t.timestamps
    end
    
    add_index :cocktails, :base_spirit
  end
end
