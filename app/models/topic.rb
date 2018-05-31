class Topic < ApplicationRecord
  include PgSearch
  multisearchable :against => :subject

  belongs_to :user, inverse_of: :topics
  has_many :replies, dependent: :destroy
  has_many :tags, inverse_of: :topic, dependent: :destroy
  has_many :bumps, inverse_of: :topic, dependent: :destroy
  has_many :objections, inverse_of: :topic, dependent: :destroy

  mount_uploader :image, ImageUploader

  default_scope -> { order(updated_at: :desc) }

  validates_presence_of :subject

  def self.by(association)
    with = joins(association.to_sym).group(:id).count.sort_by{|k,v| v}.reverse.collect{|t| t.first}
    without = Topic.where.not(id: with).collect(&:id)
    (with + without).collect{|id| Topic.find(id)}
  end

  def self.search(search)
    where("subject ~* ?", search)
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
