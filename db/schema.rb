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

ActiveRecord::Schema.define(version: 20140729130735) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaign_operator_programs", force: true do |t|
    t.integer  "campaign_id"
    t.integer  "operator_id"
    t.integer  "online_program_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaign_operator_programs", ["campaign_id"], name: "index_campaign_operator_programs_on_campaign_id", using: :btree
  add_index "campaign_operator_programs", ["operator_id", "online_program_id"], name: "index_operator_online_program", using: :btree

  create_table "campaigns", force: true do |t|
    t.string   "name"
    t.integer  "max_views"
    t.integer  "views",                               default: 0
    t.integer  "clicks",                              default: 0
    t.string   "trophy_name"
    t.string   "landing_page",           limit: 1000
    t.text     "website_banner_html_01"
    t.text     "website_banner_html_02"
    t.text     "website_banner_html_03"
    t.text     "website_banner_html_04"
    t.text     "website_banner_html_05"
    t.text     "website_banner_html_06"
    t.text     "website_banner_html_07"
    t.text     "website_banner_html_08"
    t.text     "website_banner_html_09"
    t.text     "website_banner_html_10"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "banner_image"
  end

  add_index "campaigns", ["name"], name: "index_campaigns_on_name", using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "images", force: true do |t|
    t.string   "url"
    t.string   "thumbnail_url"
    t.string   "name"
    t.text     "description"
    t.string   "format"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interactive_videos", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "language_code_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content_mobile"
  end

  create_table "language_codes", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.string   "name"
    t.integer  "language_code_id"
    t.text     "description"
    t.text     "title"
    t.text     "facebook_content"
    t.text     "email_content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "language_code"
  end

  create_table "online_program_interactive_videos", force: true do |t|
    t.integer  "online_program_id"
    t.integer  "interactive_video_id"
    t.integer  "start_after_days"
    t.time     "start_time"
    t.integer  "pre_survey_id"
    t.integer  "post_survey_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "online_program_interactive_videos", ["interactive_video_id"], name: "index_online_program_interactive_videos_on_interactive_video_id", using: :btree
  add_index "online_program_interactive_videos", ["online_program_id"], name: "index_online_program_interactive_videos_on_online_program_id", using: :btree

  create_table "online_program_notifications", force: true do |t|
    t.integer  "online_program_id"
    t.integer  "notification_id"
    t.integer  "start_after_days"
    t.time     "start_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "online_program_notifications", ["notification_id"], name: "index_online_program_notifications_on_notification_id", using: :btree
  add_index "online_program_notifications", ["online_program_id"], name: "index_online_program_notifications_on_online_program_id", using: :btree

  create_table "online_programs", force: true do |t|
    t.string   "name"
    t.string   "codename"
    t.integer  "language_code_id"
    t.text     "description"
    t.integer  "background_image_id"
    t.integer  "promo_video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sign_up_survey_id"
  end

  add_index "online_programs", ["codename"], name: "index_online_programs_on_codename", using: :btree
  add_index "online_programs", ["language_code_id"], name: "index_online_programs_on_language_code_id", using: :btree
  add_index "online_programs", ["name"], name: "index_online_programs_on_name", using: :btree

  create_table "online_programs_operators", force: true do |t|
    t.integer  "online_program_id"
    t.integer  "operator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "online_programs_operators", ["operator_id", "online_program_id"], name: "online_program_operator_index", unique: true, using: :btree
  add_index "online_programs_operators", ["operator_id"], name: "index_online_programs_operators_on_operator_id", using: :btree

  create_table "operator_mobile_stations", force: true do |t|
    t.integer  "operator_id"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "operator_mobile_stations", ["code"], name: "index_operator_mobile_stations_on_code", using: :btree
  add_index "operator_mobile_stations", ["operator_id"], name: "index_operator_mobile_stations_on_operator_id", using: :btree

  create_table "operators", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "country"
    t.string   "reg_code_prefix",        limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",               default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "last_reg_code_id"
    t.boolean  "disabled",                         default: false
  end

  add_index "operators", ["confirmation_token"], name: "index_operators_on_confirmation_token", unique: true, using: :btree
  add_index "operators", ["email"], name: "index_operators_on_email", unique: true, using: :btree
  add_index "operators", ["name"], name: "index_operators_on_name", using: :btree
  add_index "operators", ["reset_password_token"], name: "index_operators_on_reset_password_token", unique: true, using: :btree

  create_table "player_answers", force: true do |t|
    t.integer  "player_group_id"
    t.integer  "survey_id"
    t.integer  "question_id"
    t.integer  "answer_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "player_id"
  end

  add_index "player_answers", ["player_id"], name: "index_player_answers_on_player_id", using: :btree

  create_table "player_api_keys", force: true do |t|
    t.string   "access_token"
    t.datetime "expires_at"
    t.integer  "player_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_api_keys", ["access_token"], name: "index_player_api_keys_on_access_token", unique: true, using: :btree
  add_index "player_api_keys", ["player_id"], name: "index_player_api_keys_on_player_id", using: :btree

  create_table "player_authentications", force: true do |t|
    t.integer  "player_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "token_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_authentications", ["player_id"], name: "index_player_authentications_on_player_id", unique: true, using: :btree

  create_table "player_group_associations", force: true do |t|
    t.integer  "player_id"
    t.integer  "player_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_group_associations", ["player_group_id", "player_id"], name: "index_player_group_assoc_on_player_group_id_and_player_id", unique: true, using: :btree
  add_index "player_group_associations", ["player_group_id"], name: "index_player_group_associations_on_player_group_id", using: :btree
  add_index "player_group_associations", ["player_id"], name: "index_player_group_associations_on_player_id", using: :btree

  create_table "player_group_exts", force: true do |t|
    t.integer  "player_group_id"
    t.string   "custom_01"
    t.string   "custom_02"
    t.string   "custom_03"
    t.string   "custom_04"
    t.string   "custom_05"
    t.string   "custom_06"
    t.string   "custom_07"
    t.string   "custom_08"
    t.string   "custom_09"
    t.string   "custom_10"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_group_exts", ["player_group_id"], name: "index_player_group_exts_on_player_group_id", unique: true, using: :btree

  create_table "player_groups", force: true do |t|
    t.integer  "operator_id"
    t.string   "reg_code"
    t.date     "screening_date"
    t.string   "name"
    t.text     "description"
    t.integer  "player_organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mobile_station_code"
    t.datetime "deleted_at"
    t.integer  "online_program_id"
  end

  add_index "player_groups", ["description"], name: "index_player_groups_on_description", using: :btree
  add_index "player_groups", ["name"], name: "index_player_groups_on_name", using: :btree
  add_index "player_groups", ["operator_id"], name: "index_player_groups_on_operator_id", using: :btree
  add_index "player_groups", ["player_organization_id"], name: "index_player_groups_on_player_organization_id", using: :btree
  add_index "player_groups", ["reg_code"], name: "index_player_groups_on_reg_code", unique: true, using: :btree

  create_table "player_invites", force: true do |t|
    t.integer  "inviting_player_id"
    t.text     "email"
    t.string   "friend_type"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "invited_player_id"
  end

  add_index "player_invites", ["inviting_player_id"], name: "index_player_invites_on_inviting_player_id", using: :btree

  create_table "player_organization_exts", force: true do |t|
    t.integer  "player_organization_id"
    t.string   "custom_01"
    t.string   "custom_02"
    t.string   "custom_03"
    t.string   "custom_04"
    t.string   "custom_05"
    t.string   "custom_06"
    t.string   "custom_07"
    t.string   "custom_08"
    t.string   "custom_09"
    t.string   "custom_10"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_organization_exts", ["player_organization_id"], name: "index_player_organization_exts_on_player_organization_id", unique: true, using: :btree

  create_table "player_organizations", force: true do |t|
    t.string   "org_type"
    t.string   "name"
    t.text     "address"
    t.string   "contact_name"
    t.string   "contact_position"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "operator_id"
    t.datetime "deleted_at"
  end

  add_index "player_organizations", ["contact_email"], name: "index_player_organizations_on_contact_email", using: :btree
  add_index "player_organizations", ["name"], name: "index_player_organizations_on_name", using: :btree
  add_index "player_organizations", ["operator_id"], name: "index_player_organizations_on_operator_id", using: :btree

  create_table "player_progresses", force: true do |t|
    t.integer  "player_id"
    t.integer  "player_group_id"
    t.integer  "last_interactive_video_index", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_progresses", ["player_id", "player_group_id"], name: "index_player_progresses_on_player_id_and_player_group_id", using: :btree

  create_table "player_score_updates", force: true do |t|
    t.integer  "player_id"
    t.string   "event"
    t.integer  "points"
    t.boolean  "reported",   default: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_score_updates", ["player_id"], name: "index_player_score_updates_on_player_id", using: :btree

  create_table "player_sessions", force: true do |t|
    t.integer  "player_id"
    t.datetime "sign_in_at"
    t.datetime "sign_out_at"
    t.string   "ip_address"
    t.string   "session_id"
  end

  add_index "player_sessions", ["player_id"], name: "index_player_sessions_on_player_id", using: :btree

  create_table "players", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birth_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "gender"
    t.string   "profile_picture"
    t.integer  "age"
    t.boolean  "tos_accepted",           default: false
  end

  add_index "players", ["confirmation_token"], name: "index_players_on_confirmation_token", unique: true, using: :btree
  add_index "players", ["email"], name: "index_players_on_email", unique: true, using: :btree
  add_index "players", ["reset_password_token"], name: "index_players_on_reset_password_token", unique: true, using: :btree
  add_index "players", ["username"], name: "index_players_on_username", unique: true, using: :btree

  create_table "questions", force: true do |t|
    t.string   "name"
    t.integer  "language_code_id"
    t.text     "question"
    t.text     "answers"
    t.integer  "correct_answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions_surveys", force: true do |t|
    t.integer  "question_id"
    t.integer  "survey_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_number"
  end

  create_table "registration_codes", force: true do |t|
    t.string "code"
  end

  create_table "scores", force: true do |t|
    t.integer  "player_group_id"
    t.integer  "player_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scores", ["player_group_id"], name: "index_scores_on_player_group_id", using: :btree
  add_index "scores", ["player_id"], name: "index_scores_on_player_id", using: :btree

  create_table "settings", force: true do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "surveys", force: true do |t|
    t.string   "name"
    t.integer  "language_code_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "system_admins", force: true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "super_admin"
  end

  add_index "system_admins", ["confirmation_token"], name: "index_system_admins_on_confirmation_token", unique: true, using: :btree
  add_index "system_admins", ["email"], name: "index_system_admins_on_email", unique: true, using: :btree
  add_index "system_admins", ["first_name"], name: "index_system_admins_on_first_name", using: :btree
  add_index "system_admins", ["last_name"], name: "index_system_admins_on_last_name", using: :btree
  add_index "system_admins", ["reset_password_token"], name: "index_system_admins_on_reset_password_token", unique: true, using: :btree

  create_table "videos", force: true do |t|
    t.string   "url"
    t.string   "thumbnail_url"
    t.string   "name"
    t.integer  "language_code_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
