class Job < ApplicationRecord
  belongs_to :worker
  belongs_to :work_order

  validates :worker_id, uniqueness: {scope: :work_order_id}
end
