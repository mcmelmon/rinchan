module TopicsHelper
  def current_user_bumped_topic?(topic)
    topic.bumps.find_by(user_id: current_user&.id).present?
  end

  def current_user_objected_to_topic?(topic)
    topic.objections.find_by(user_id: current_user&.id).present?
  end

  def reply_belongs_to_current_user?(reply)
    reply.user == current_user
  end

  def topic_belongs_to_current_user?(topic)
    topic.user == current_user
  end
end
