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

ActiveRecord::Schema.define(:version => 20130111211309) do

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "exercises", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "course_id"
  end

  create_table "levenshtein_similarities", :force => true do |t|
    t.float    "similarity"
    t.integer  "exercise_id"
    t.integer  "submission_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "levenshtein_similarity_for_two_submissions", :force => true do |t|
    t.float    "similarity"
    t.integer  "from_submission"
    t.integer  "to_submission"
    t.integer  "exercise_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "model_solutions", :force => true do |t|
    t.string   "filename"
    t.integer  "exercise_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "submission_files", :force => true do |t|
    t.string   "filename"
    t.text     "code"
    t.integer  "submission_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "exercise_id"
    t.integer  "model_solution_id"
  end

  add_index "submission_files", ["submission_id"], :name => "index_submission_files_on_submission_id"

  create_table "submissions", :force => true do |t|
    t.string   "identifier"
    t.integer  "exercise_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
    t.boolean  "super_admin",        :default => false
    t.boolean  "disabled",           :default => false
    t.datetime "last_login"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

end
