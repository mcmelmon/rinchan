class Reply < ApplicationRecord
  include PgSearch
  multisearchable :against => :body
  mount_uploader :image, ImageUploader

  belongs_to :user, inverse_of: :replies
  belongs_to :topic, inverse_of: :replies
  has_many :thanks, inverse_of: :reply, dependent: :destroy
  has_many :demurrals, inverse_of: :reply, dependent: :destroy
  has_many :replies, class_name: 'Reply', foreign_key: :original_id
  has_one :topic_link, as: :parent, inverse_of: :parent, dependent: :destroy

  default_scope -> { order(updated_at: :desc) }

  scope :topic_answers_for_user, -> (user) { where(topic_id: user.topics).where.not(user_id: user.id) } 
  scope :reply_answers_for_user, -> (user) { where(original_id: user.replies).where.not(user_id: user.id) } 

  validates_presence_of :body

  def get_all_replies
    return if replies.blank?
    replies.each { |r| r.get_all_replies }
  end

  def link?
    topic_link.present?
  end

  def original
    Reply.find_by(id: original_id)
  end
end
