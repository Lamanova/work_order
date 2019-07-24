class CreateWorkOrder < ActiveRecord::Migration[5.1]
  def change
    create_table :work_orders do |t|
      t.string :title
      t.text :description
      t.datetime :deadline

      t.timestamps
    end
  end
end
