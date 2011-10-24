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

ActiveRecord::Schema.define(:version => 20111024184027) do

  create_table "apn_devices", :force => true do |t|
    t.string   "token",              :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_registered_at"
    t.integer  "user_id"
  end

  add_index "apn_devices", ["token"], :name => "index_apn_devices_on_token", :unique => true

  create_table "apn_notifications", :force => true do |t|
    t.integer  "device_id",                        :null => false
    t.integer  "errors_nb",         :default => 0
    t.string   "device_language"
    t.string   "sound"
    t.string   "alert"
    t.integer  "badge"
    t.text     "custom_properties"
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apn_notifications", ["device_id"], :name => "index_apn_notifications_on_device_id"

  create_table "comments", :force => true do |t|
    t.string   "text"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "filters", :force => true do |t|
    t.string   "name"
    t.string   "version"
    t.float    "layer1_opacity"
    t.string   "layer1_blend_mode"
    t.string   "layer1_landscape_preview_image"
    t.string   "layer1_portrait_preview_image"
    t.string   "layer1_landscape_image"
    t.string   "layer1_portrait_image"
    t.float    "layer2_opacity"
    t.string   "layer2_blend_mode"
    t.string   "layer2_landscape_preview_image"
    t.string   "layer2_portrait_preview_image"
    t.string   "layer2_landscape_image"
    t.string   "layer2_portrait_image"
    t.float    "layer3_opacity"
    t.string   "layer3_blend_mode"
    t.string   "layer3_landscape_preview_image"
    t.string   "layer3_portrait_preview_image"
    t.string   "layer3_landscape_image"
    t.string   "layer3_portrait_image"
    t.string   "package"
    t.float    "release"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "filter_type"
  end

  create_table "flags", :force => true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flurry_events", :force => true do |t|
    t.date     "date"
    t.integer  "session_index"
    t.string   "event"
    t.string   "description"
    t.string   "version"
    t.string   "platform"
    t.string   "device"
    t.string   "user_id"
    t.string   "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flurry_records", :force => true do |t|
    t.date     "date"
    t.integer  "sessions"
    t.integer  "new_users"
    t.integer  "retained_users"
    t.integer  "active_users"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "followings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "follower_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "caption"
    t.string   "twitter_screen_name"
    t.integer  "view_count"
    t.string   "user_agent"
    t.string   "uuid"
    t.boolean  "block"
    t.string   "facebook_post_status_code"
    t.string   "facebook_post_status_body"
    t.string   "facebook_photo_id"
    t.string   "app_version"
    t.string   "device_type"
    t.string   "os_version"
    t.string   "device_id"
    t.string   "device_language"
    t.string   "ip_address"
    t.integer  "deleted"
    t.string   "twitter_post_id"
    t.text     "twitter_post_status_body"
    t.text     "twitter_post_status_code"
    t.string   "filter_name"
    t.string   "filter_version"
    t.integer  "user_id"
    t.string   "migrated"
    t.string   "image"
    t.string   "ptype"
    t.boolean  "twitter_cross_post"
    t.string   "facebook_cross_post_pages"
  end

  add_index "posts", ["code"], :name => "index_photos_on_code"
  add_index "posts", ["id"], :name => "idx_photos_id"

  create_table "responses", :force => true do |t|
  end

  create_table "services", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.string   "secret"
    t.string   "nickname"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "location"
    t.string   "description"
    t.string   "image"
    t.string   "phone"
    t.string   "urls"
    t.string   "user_hash"
  end

  create_table "sharings", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "temp_latest_facebook_data", :id => false, :force => true do |t|
    t.string "facebook_user_id"
    t.string "facebook_access_token"
  end

  add_index "temp_latest_facebook_data", ["facebook_user_id"], :name => "idx3"

  create_table "temp_latest_twitter_data", :id => false, :force => true do |t|
    t.string "twitter_screen_name"
    t.string "twitter_oauth_token"
    t.string "twitter_oauth_secret"
    t.string "twitter_avatar_url"
  end

  add_index "temp_latest_twitter_data", ["twitter_screen_name"], :name => "idx7"

  create_table "user_filters", :force => true do |t|
    t.integer  "user_id"
    t.integer  "filter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_filters", ["user_id", "filter_id"], :name => "index_user_filters_on_user_id_and_filter_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "twitter_screen_name"
    t.string   "twitter_oauth_token"
    t.string   "twitter_oauth_secret"
    t.string   "twitter_avatar_url"
    t.string   "facebook_access_token"
    t.string   "facebook_user_id"
    t.string   "email",                                    :default => "", :null => false
    t.string   "encrypted_password",        :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                            :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "slug"
    t.string   "authentication_token"
    t.string   "charity_name"
    t.string   "charity_link"
    t.string   "charity_pic"
    t.boolean  "twitter_cross_post"
    t.string   "facebook_cross_post_pages"
    t.string   "facebook_like_target"
    t.boolean  "verified"
  end

  create_table "view_logs", :force => true do |t|
    t.string "code"
    t.string "user_agent"
    t.string "ip_address"
  end

end
