class Topic < ApplicationRecord
  belongs_to :user, inverse_of: :topics
  has_many :replies, dependent: :destroy
  has_many :tags, inverse_of: :topic, dependent: :destroy
  has_many :bumps, inverse_of: :topic, dependent: :destroy
  has_many :objections, inverse_of: :topic, dependent: :destroy

  default_scope -> { order(updated_at: :desc) }

  validates_presence_of :subject

  def self.by(association)
    left_joins(:replies)
      .group(:id)
      .count
      .sort_by{|k,v| v}
      .collect{|t| Topic.find_by(id: t.first)}
      .reverse
  end

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
