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

ActiveRecord::Schema.define(version: 2021_10_15_190553) do

  create_table "offers", force: :cascade do |t|
    t.text "description"
    t.decimal "value"
    t.integer "hours"
    t.date "finish_date"
    t.integer "status", default: 0
    t.integer "professional_id"
    t.integer "plan_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plan_id"], name: "index_offers_on_plan_id"
    t.index ["professional_id"], name: "index_offers_on_professional_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "hability"
    t.decimal "value"
    t.date "limit_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.string "presence_type"
    t.integer "status", default: 0
    t.index ["user_id"], name: "index_plans_on_user_id"
  end

  create_table "professional_feedbacks", force: :cascade do |t|
    t.text "text"
    t.integer "rate"
    t.integer "professional_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["professional_id"], name: "index_professional_feedbacks_on_professional_id"
    t.index ["user_id"], name: "index_professional_feedbacks_on_user_id"
  end

  create_table "professionalfeedbacks", force: :cascade do |t|
    t.text "text"
    t.integer "rate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "professional_id"
    t.integer "user_id"
    t.index ["professional_id"], name: "index_professionalfeedbacks_on_professional_id"
    t.index ["user_id"], name: "index_professionalfeedbacks_on_user_id"
  end

  create_table "professionals", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_professionals_on_email", unique: true
    t.index ["reset_password_token"], name: "index_professionals_on_reset_password_token", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "social_name"
    t.string "background"
    t.string "description"
    t.string "area"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "professional_id"
    t.index ["professional_id"], name: "index_profiles_on_professional_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "offers", "plans"
  add_foreign_key "offers", "professionals"
  add_foreign_key "plans", "users"
  add_foreign_key "professional_feedbacks", "professionals"
  add_foreign_key "professional_feedbacks", "users"
  add_foreign_key "professionalfeedbacks", "professionals"
  add_foreign_key "professionalfeedbacks", "users"
  add_foreign_key "profiles", "professionals"
end
