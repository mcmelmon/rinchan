class Topic < ApplicationRecord
  belongs_to :user, inverse_of: :topics
  has_many :replies, dependent: :destroy
  has_many :tags, inverse_of: :topic, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  validates_presence_of :subject

  def self.with_tag(name)
    Tag.where(name: name).collect(&:topic)
  end

  def clear_tags
    tags.each { |tag| tag.destroy }
  end

  def display_tags
    tags.collect(&:name).join(', ')
  end
end
