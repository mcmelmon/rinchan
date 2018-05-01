module TopicsHelper
  def reply_belongs_to_current_user?(reply)
    reply.user == current_user
  end

  def topic_belongs_to_current_user?(topic)
    topic.user == current_user
  end
end
