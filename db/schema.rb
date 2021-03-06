# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170516185157) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "grocery_lists", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_grocery_lists_on_user_id", using: :btree
  end

  create_table "ingredients", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "parent_type"
    t.string   "unit"
    t.string   "amount"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "meal_plans", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_meal_plans_on_user_id", using: :btree
  end

  create_table "meal_plans_recipes", id: false, force: :cascade do |t|
    t.integer "recipe_id",    null: false
    t.integer "meal_plan_id", null: false
    t.index ["meal_plan_id"], name: "index_meal_plans_recipes_on_meal_plan_id", using: :btree
    t.index ["recipe_id"], name: "index_meal_plans_recipes_on_recipe_id", using: :btree
  end

  create_table "recipes", force: :cascade do |t|
    t.string  "name"
    t.text    "steps"
    t.integer "time"
    t.integer "user_id"
    t.string  "link"
    t.text    "ingredients_block"
    t.index ["user_id"], name: "index_recipes_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
