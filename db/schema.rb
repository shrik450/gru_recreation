# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_13_053800) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", id: :string, force: :cascade do |t|
    t.text "body"
    t.integer "score"
    t.string "author"
    t.string "subreddit"
    t.string "parent_id", null: false
    t.boolean "edited"
    t.string "removal_reason"
    t.boolean "can_gild"
    t.boolean "can_mod_post"
    t.boolean "collapsed"
    t.string "collapsed_reason"
    t.integer "controversiality"
    t.boolean "distinguished"
    t.boolean "is_submitter"
    t.boolean "no_follow"
    t.boolean "removed"
    t.datetime "created_utc"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "parent_type", null: false
    t.index ["author"], name: "index_comments_on_author"
    t.index ["parent_id"], name: "index_comments_on_parent_id"
    t.index ["score"], name: "index_comments_on_score"
    t.index ["subreddit"], name: "index_comments_on_subreddit"
  end

  create_table "posts", id: :string, force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.text "selftext"
    t.integer "score"
    t.string "author"
    t.string "subreddit"
    t.boolean "locked"
    t.boolean "is_self"
    t.integer "num_comments"
    t.integer "num_crossposts"
    t.datetime "created_utc"
    t.integer "edited"
    t.integer "hidden"
    t.string "removal_reason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author"], name: "index_posts_on_author"
    t.index ["score"], name: "index_posts_on_score"
    t.index ["subreddit"], name: "index_posts_on_subreddit"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
