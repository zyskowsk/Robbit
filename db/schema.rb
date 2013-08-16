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

ActiveRecord::Schema.define(:version => 20130816233016) do

  create_table "comment_votes", :force => true do |t|
    t.integer  "comment_id"
    t.integer  "user_id"
    t.integer  "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comment_votes", ["comment_id"], :name => "index_comment_votes_on_comment_id"
  add_index "comment_votes", ["user_id"], :name => "index_comment_votes_on_usar_id"

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "parent_id"
    t.integer  "link_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  add_index "comments", ["link_id"], :name => "index_comments_on_link_id"
  add_index "comments", ["parent_id"], :name => "index_comments_on_parent_id"

  create_table "links", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "links", ["user_id"], :name => "index_links_on_user_id"

  create_table "sub_links", :force => true do |t|
    t.integer  "sub_id"
    t.integer  "link_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sub_links", ["link_id"], :name => "index_sub_links_on_link_id"
  add_index "sub_links", ["sub_id"], :name => "index_sub_links_on_sub_id"

  create_table "subs", :force => true do |t|
    t.string   "name"
    t.integer  "moderator_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "subs", ["moderator_id"], :name => "index_subs_on_moderatior_id"

  create_table "user_votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "link_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "value"
  end

  add_index "user_votes", ["link_id"], :name => "index_user_votes_on_link_id"
  add_index "user_votes", ["user_id"], :name => "index_user_votes_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username",        :null => false
    t.string   "email",           :null => false
    t.string   "name",            :null => false
    t.string   "session_key"
    t.string   "password_digest", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
