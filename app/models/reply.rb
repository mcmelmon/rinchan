class Reply < ApplicationRecord
  include PgSearch
  multisearchable :against => :body

  belongs_to :user, inverse_of: :replies
  belongs_to :topic, inverse_of: :replies

  default_scope -> { order(updated_at: :desc) }

  validates_presence_of :body
end
