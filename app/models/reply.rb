class Reply < ApplicationRecord
  include PgSearch
  multisearchable :against => :body

  belongs_to :user, inverse_of: :replies
  belongs_to :topic, inverse_of: :replies
  has_many :thanks, inverse_of: :reply, dependent: :destroy
  has_many :demurrals, inverse_of: :reply, dependent: :destroy

  default_scope -> { order(updated_at: :desc) }

  validates_presence_of :body
end
