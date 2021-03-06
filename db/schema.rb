# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141109215403) do

  create_table "lessons", force: true do |t|
    t.string   "title"
    t.string   "tags"
    t.text     "text"
    t.text     "audio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "video"
    t.text     "answer"
    t.text     "tweet"
    t.text     "pronunciation"
    t.integer  "lesson_order"
  end

  create_table "tracks", force: true do |t|
    t.integer "user_id"
    t.integer "lesson_id"
    t.string  "track_url"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "admin"
    t.integer  "best_streak",            default: 0
    t.boolean  "active_subscription"
    t.integer  "last_lesson",            default: 0
    t.string   "customer_id",            default: ""
    t.integer  "streak",                 default: 0
    t.integer  "points",                 default: 0
    t.integer  "last_calculated_streak", default: 0
    t.boolean  "trialing",               default: true
    t.datetime "trial_began"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
