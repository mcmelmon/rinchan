module BulletinsHelper
  def bulletin_belongs_to_current_user?(bulletin)
    bulletin.user == current_user
  end
end
