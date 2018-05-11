class UsersController < ApplicationController
  before_action :correct_user

  def show
    # @bulletins = @user.bulletins.paginate(page: params[:page])
    @topics = @user.topics.paginate(page: params[:page], per_page: 10)
    @replies = @user.replies.paginate(page: params[:page], per_page: 10)
  end

  private
    def correct_user
      @user = current_user # or someday an admin, friend
      redirect_to root_url if @user.nil?
    end
end
