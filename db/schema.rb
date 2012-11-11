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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121110151044) do

  create_table "clients", :force => true do |t|
    t.integer  "form_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "clients_forms", :id => false, :force => true do |t|
    t.integer "client_id"
    t.integer "form_id"
  end

  create_table "comments", :force => true do |t|
    t.integer  "feedback_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "csm_properties", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "feedback_types", :force => true do |t|
    t.string "name"
    t.string "image_url"
  end

  create_table "feedbacks", :force => true do |t|
    t.integer  "project_id"
    t.integer  "feedback_type_id"
    t.integer  "user_id"
    t.string   "subject"
    t.text     "content"
    t.boolean  "client_visibility"
    t.boolean  "mooveit_visibility"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "forms", :force => true do |t|
    t.integer  "client_id"
    t.string   "name"
    t.string   "email"
    t.text     "wise_token"
    t.text     "writely_token"
    t.integer  "actual_total_answers", :default => 0
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "forms", ["name", "email"], :name => "index_forms_on_name_and_email", :unique => true

  create_table "milestones", :force => true do |t|
    t.integer "project_id"
    t.string  "name"
    t.date    "target_date"
  end

  create_table "moods", :force => true do |t|
    t.integer  "project_id"
    t.integer  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.boolean  "feedbacks_notifications", :default => true
    t.boolean  "comments_notifications",  :default => true
    t.boolean  "show_gravatar",           :default => true
    t.string   "skype_usr"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "projects", :force => true do |t|
    t.integer  "client_id"
    t.integer  "mood_id"
    t.string   "name"
    t.text     "description"
    t.datetime "end_date"
    t.boolean  "finalized"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.datetime "last_reminder_email_sent"
  end

  add_index "projects", ["client_id"], :name => "index_projects_on_client_id"

  create_table "roles", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.integer  "role_id"
    t.integer  "client_id"
    t.string   "username"
    t.string   "full_name"
    t.string   "email"
    t.string   "openidemail"
    t.string   "encrypted_password",     :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "disable",                :default => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "users", ["client_id"], :name => "index_users_on_client_id"
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true

end
