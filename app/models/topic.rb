class Topic < ApplicationRecord
  include PgSearch
  multisearchable :against => :subject
  mount_uploader :image, ImageUploader

  belongs_to :user, inverse_of: :topics
  has_many :replies, dependent: :destroy
  has_many :tags, inverse_of: :topic, dependent: :destroy
  has_many :bumps, inverse_of: :topic, dependent: :destroy
  has_many :objections, inverse_of: :topic, dependent: :destroy

  default_scope -> { order(updated_at: :desc) }

  scope :editorials, -> { joins(:user).merge(User.editors).order(updated_at: :DESC) }
  scope :non_editorials, -> { joins(:user).merge(User.civilians).order(updated_at: :DESC) }

  validates_presence_of :subject

  def self.by(association)
    with = joins(association.to_sym).group(:id).count.sort_by{|k,v| v}.reverse.collect{|t| t.first}
    without = Topic.where.not(id: with).collect(&:id)
    (with + without).collect{|id| Topic.find(id)}
  end

  def self.for_homepage(current_user, sorting = nil)
    choose_homepage_topics(current_user, sorting)
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

  private
    def self.choose_homepage_topics(current_user, sorting)
      display_topics = []

      if sorting.present?
        Topic.by(sorting)
        # editor_topics = editorials.by(sorting)[0..30]
        # civilian_topics = non_editorials.by(sorting)[0..30]
      else
        Topic.all
        # editor_topics = editorials.limit(30)
        # civilian_topics = non_editorials.limit(30)
      end

      # if current_user.present? && current_user.topics.present? && !current_user.editor?
        # display_topics << current_user.topics.first
      # end

      # display_topics <<  editor_topics[0..6]
      # display_topics << (editor_topics.drop(7) + civilian_topics).shuffle
      # display_topics.flatten.compact
    end
end
