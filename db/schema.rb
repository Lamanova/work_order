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

ActiveRecord::Schema.define(version: 20_190_720_201_800) do
  create_table 'jobs', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
    t.bigint 'worker_id'
    t.bigint 'work_order_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['work_order_id'], name: 'index_jobs_on_work_order_id'
    t.index ['worker_id'], name: 'index_jobs_on_worker_id'
  end

  create_table 'work_orders', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
    t.string 'title'
    t.text 'description'
    t.datetime 'deadline'
  end

  create_table 'workers', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
    t.string 'name'
    t.string 'company_name'
    t.string 'email'
  end
end
