# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_02_06_130222) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "expenses", force: :cascade do |t|
    t.date "date"
    t.bigint "step_id", null: false
    t.bigint "supplier_id", null: false
    t.string "description"
    t.bigint "payment_method_id", null: false
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payment_method_id"], name: "index_expenses_on_payment_method_id"
    t.index ["step_id"], name: "index_expenses_on_step_id"
    t.index ["supplier_id"], name: "index_expenses_on_supplier_id"
  end

  create_table "materials", force: :cascade do |t|
    t.bigint "supplier_id", null: false
    t.string "name"
    t.string "url"
    t.decimal "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_id"], name: "index_materials_on_supplier_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "steps", force: :cascade do |t|
    t.string "name"
    t.decimal "budget"
    t.decimal "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "budget"
    t.string "color"
  end

  create_table "task_materials", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.bigint "material_id", null: false
    t.integer "quantity"
    t.decimal "unit_price"
    t.decimal "taxes_amount"
    t.decimal "total_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_id"], name: "index_task_materials_on_material_id"
    t.index ["task_id"], name: "index_task_materials_on_task_id"
  end

  create_table "task_relations", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.bigint "blocked_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blocked_by_id"], name: "index_task_relations_on_blocked_by_id"
    t.index ["task_id"], name: "index_task_relations_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "supplier_id", null: false
    t.string "name"
    t.decimal "budget"
    t.decimal "cost"
    t.integer "estimated_time"
    t.integer "time_elapsed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_date"
    t.date "completed_on"
    t.date "planned_start_date"
    t.date "planned_end_date"
    t.integer "duration_in_days"
    t.date "started_on"
    t.index ["supplier_id"], name: "index_tasks_on_supplier_id"
  end

  add_foreign_key "expenses", "payment_methods"
  add_foreign_key "expenses", "steps"
  add_foreign_key "expenses", "suppliers"
  add_foreign_key "materials", "suppliers"
  add_foreign_key "task_materials", "materials"
  add_foreign_key "task_materials", "tasks"
  add_foreign_key "task_relations", "tasks"
  add_foreign_key "task_relations", "tasks", column: "blocked_by_id"
  add_foreign_key "tasks", "suppliers"
end
