class Bulletin < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }

  validates_presence_of :body
end
