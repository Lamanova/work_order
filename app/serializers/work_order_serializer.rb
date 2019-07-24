class WorkOrderSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :deadline

  has_many :workers

  def deadline
    object.deadline.strftime('%B %d, %Y')
  end
end
