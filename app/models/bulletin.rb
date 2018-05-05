class Bulletin < ApplicationRecord
  include PgSearch
  multisearchable :against => :body

  belongs_to :user

  default_scope -> { order(updated_at: :desc) }

  validates_presence_of :body
end
