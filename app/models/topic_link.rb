class TopicLink < ApplicationRecord
  belongs_to :parent, inverse_of: :topic_link, polymorphic: :true

  def parent
    (parent_type == 'Topic') ? Topic.find_by(id: parent_id) : Reply.find_by(id: parent_id)
  end
end
