# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2026_02_24_224114) do
  create_table "cocktails", force: :cascade do |t|
    t.string "name", null: false
    t.integer "base_spirit", null: false
    t.integer "publication_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["base_spirit"], name: "index_cocktails_on_base_spirit"
    t.index ["publication_id"], name: "index_cocktails_on_publication_id"
  end

  create_table "publications", force: :cascade do |t|
    t.string "title", null: false
    t.string "author"
    t.integer "publication_type", null: false
    t.integer "publication_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_type"], name: "index_publications_on_publication_type"
    t.index ["publication_year"], name: "index_publications_on_publication_year"
  end

  add_foreign_key "cocktails", "publications"
end
