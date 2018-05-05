class Tag < ApplicationRecord
  include PgSearch
  multisearchable :against => :name

  belongs_to :user, inverse_of: :tags
  belongs_to :topic, inverse_of: :tags

  validates_presence_of :name

  # Implementation Discussion
  #
  # A tag belongs to one user and one topic.  This will result in some
  # inefficiency relative to a global tag, or even a user level tag for
  # available to all of the user's topics.  For example, instead of one
  # "DeAnza College" for the entire site, or for one user, there is 
  # one for each topic about DeAnza College.  This is intentional, as it
  # provides more flexibility to the user.  There is no need to search for
  # existing tags, or for the user to worry about picking the 'right' tag.
  #
  # The search functionality will be responsible for collecting topics 
  # with a particular tag together, and it will have to identify tags that
  # are variations (e.g. Deanza, DeAnzaCollege, de anza) and collecting their
  # topics.

  def self.first_with_name(name)
    find_by(name: name)
  end

  def self.unique_names
    all.collect(&:name).uniq
  end
end
