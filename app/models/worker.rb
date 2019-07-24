class Worker < ApplicationRecord
  has_many :jobs, dependent: :destroy
  has_many :work_orders, through: :jobs

  validates :name, presence: true
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true
end
