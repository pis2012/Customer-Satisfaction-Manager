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

ActiveRecord::Schema.define(:version => 20120921023433) do

  create_table "clients", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "feedbacks", :force => true do |t|
    t.string   "subject"
    t.integer  "visibility"
    t.string   "content"
    t.integer  "project_id"
    t.integer  "author_id"
    t.integer  "type"
    t.integer  "feeling"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "milestones", :force => true do |t|
    t.string   "name"
    t.date     "target_date"
    t.integer  "project_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "moods", :force => true do |t|
    t.date     "date_created"
    t.integer  "status"
    t.integer  "project_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.date     "last_login_date"
    t.integer  "project_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name",                      :null => false
    t.string   "description",               :null => false
    t.datetime "end_date",                  :null => false
    t.string   "status",      :limit => 11
    t.integer  "client_id",                 :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "projects", ["client_id"], :name => "index_projects_on_client_id"

  create_table "roles", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "users", :force => true do |t|
    t.integer  "role_id"
    t.integer  "client_id"
    t.integer  "project_id"
    t.string   "username",                               :null => false
    t.string   "full_name",                              :null => false
    t.string   "email",                                  :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["client_id"], :name => "index_users_on_client_id"

  add_foreign_key "projects", "clients", :name => "projects_client_id_fk"

end
