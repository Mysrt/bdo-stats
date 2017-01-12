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

ActiveRecord::Schema.define(version: 20170112020737) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "guild_memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "guild_id"
    t.string   "invite_hash"
    t.integer  "invitor_id"
    t.boolean  "admin"
    t.boolean  "accepted",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["accepted"], name: "index_guild_memberships_on_accepted", using: :btree
    t.index ["created_at"], name: "index_guild_memberships_on_created_at", using: :btree
    t.index ["guild_id"], name: "index_guild_memberships_on_guild_id", using: :btree
    t.index ["invite_hash"], name: "index_guild_memberships_on_invite_hash", using: :btree
    t.index ["invitor_id"], name: "index_guild_memberships_on_invitor_id", using: :btree
    t.index ["updated_at"], name: "index_guild_memberships_on_updated_at", using: :btree
    t.index ["user_id", "guild_id"], name: "index_guild_memberships_on_user_id_and_guild_id", using: :btree
    t.index ["user_id"], name: "index_guild_memberships_on_user_id", unique: true, using: :btree
  end

  create_table "guilds", force: :cascade do |t|
    t.string   "name"
    t.string   "region"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["created_at"], name: "index_guilds_on_created_at", using: :btree
    t.index ["updated_at"], name: "index_guilds_on_updated_at", using: :btree
  end

  create_table "t_tvprices", id: false, force: :cascade do |t|
    t.string "tvmodel"
    t.date   "dateupdated"
    t.money  "price",       scale: 2
  end

  create_table "users", force: :cascade do |t|
    t.string   "encrypted_password",           default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "ap"
    t.integer  "dp"
    t.string   "name"
    t.string   "family_name"
    t.string   "region"
    t.string   "gear_screenshot_url"
    t.boolean  "bhegs"
    t.boolean  "tree"
    t.boolean  "muskan"
    t.boolean  "giath"
    t.boolean  "kutum"
    t.boolean  "zaka"
    t.boolean  "dandy"
    t.boolean  "allow_public_stat_calc",       default: true
    t.boolean  "allow_private_stat_calc",      default: true
    t.boolean  "nouver"
    t.integer  "level"
    t.integer  "awakening_ap"
    t.integer  "energy"
    t.integer  "contribution"
    t.string   "username"
    t.string   "gear_screenshot_file_name"
    t.string   "gear_screenshot_content_type"
    t.integer  "gear_screenshot_file_size"
    t.datetime "gear_screenshot_updated_at"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
