class CreateJob < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.belongs_to :worker, index: true
      t.belongs_to :work_order, index: true

      t.timestamps
    end
  end
end
