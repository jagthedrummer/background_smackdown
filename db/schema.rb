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

ActiveRecord::Schema.define(version: 20131210230421) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batches", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "background_type"
    t.integer  "job_count"
    t.string   "job_type"
    t.integer  "worker_count"
    t.integer  "thread_count"
    t.float    "mean"
    t.float    "median"
    t.float    "range"
    t.float    "min"
    t.float    "max"
    t.float    "variance"
    t.float    "standard_deviation"
    t.float    "relative_standard_deviation"
    t.float    "percentile95"
    t.float    "run_time"
    t.float    "wall_time"
    t.float    "percentile25"
    t.float    "percentile75"
    t.boolean  "modified_run",                default: false
  end

  create_table "jobs", force: true do |t|
    t.integer  "batch_id"
    t.string   "type"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "start_load_1"
    t.float    "start_load_5"
    t.float    "start_load_15"
    t.float    "end_load_1"
    t.float    "end_load_5"
    t.float    "end_load_15"
    t.float    "start_user_cpu"
    t.float    "start_sys_cpu"
    t.float    "end_user_cpu"
    t.float    "end_sys_cpu"
  end

  create_table "system_stats", force: true do |t|
    t.float    "user_cpu"
    t.float    "sys_cpu"
    t.float    "load_1"
    t.float    "load_5"
    t.float    "load_15"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "batch_id"
  end

end
