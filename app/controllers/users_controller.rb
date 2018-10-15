class UsersController < ApplicationController
  before_action :correct_user

  def show
    if params[:show].blank?
      @topics = @user.topics.paginate(page: params[:page], per_page: 20)
    elsif params[:show] == 'replies'
      @replies = @user.replies.paginate(page: params[:page], per_page: 20)
    elsif params[:show] == 'answers'
      @replies = @user.answers.paginate(page: params[:page], per_page: 20)
    end
  end

  private
    def correct_user
      @user = current_user # or someday an admin, friend
      redirect_to root_url if @user.nil?
    end
end
