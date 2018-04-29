class Topic < ApplicationRecord
  belongs_to :user, inverse_of: :topics
  has_many :replies

  default_scope -> { order(created_at: :desc) }

  validates_presence_of :subject
end
