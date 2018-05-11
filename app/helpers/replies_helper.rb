module RepliesHelper
  def current_user_thanked_reply?(reply)
    reply.thanks.find_by(user_id: current_user&.id).present?
  end

  def current_user_demurred_to_reply?(reply)
    reply.demurrals.find_by(user_id: current_user&.id).present?
  end
end
