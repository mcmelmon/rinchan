class Reply < ApplicationRecord
  include PgSearch
  multisearchable :against => :body
  mount_uploader :image, ImageUploader

  belongs_to :user, inverse_of: :replies
  belongs_to :topic, inverse_of: :replies
  has_many :thanks, inverse_of: :reply, dependent: :destroy
  has_many :demurrals, inverse_of: :reply, dependent: :destroy
  has_many :replies, class_name: 'Reply', foreign_key: :original_id

  default_scope -> { order(updated_at: :desc) }

  validates_presence_of :body

  def original
    Reply.find_by(id: original_id)
  end
end
