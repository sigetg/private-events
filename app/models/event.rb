class Event < ApplicationRecord
  validates :name, presence: true, length: {minimum: 3, maximum: 100}
  validates :date, presence: true

  belongs_to :creator, class_name: 'User'
  has_many :event_attendees
  has_many :attendees, through: :event_attendees, source: :user
end
