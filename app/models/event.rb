class Event < ApplicationRecord
  validates :name, presence: true, length: {minimum: 3, maximum: 100}
  validates :date, presence: true

  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  has_many :enrollments
  has_many :attendees, through: :enrollments, source: :user
end
