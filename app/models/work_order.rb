class WorkOrder < ApplicationRecord
  class LimitReachedError < StandardError; end

  WORKER_LIMIT = 5
  SORTABLE_ATTRIBUTES = ['deadline'].freeze

  has_many :jobs, dependent: :destroy
  has_many :workers, through: :jobs, before_add: :check_worker_limit

  validates :title, presence: true

  def self.for_worker(worker_id, sort_by)
    result = worker_id.present? ? Worker.find(worker_id)&.work_orders : WorkOrder.all
    result = result.order(sort_by) if sort_by
    result
  end

  def check_worker_limit(_worker)
    raise Exceptions::LimitReachedError if workers.size >= WORKER_LIMIT
  end
end
