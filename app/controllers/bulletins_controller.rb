class BulletinsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, except: [:create]

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)
    if @bulletin.save
      flash[:notice] = "Post created!"
      redirect_to user_path(current_user)
    else
      redirect_to root_path
    end
  end

  def destroy
    @bulletin.destroy
    flash[:notice] = "Post deleted."
    redirect_to request.referrer || root_url
  end

  def edit
  end

  def update
    if @bulletin.update(bulletin_params)
      flash[:notice] = "Post updated."
      redirect_to user_path(current_user)
    else
      flash[:error] = "There was a problem."
      redirect_to user_path(current_user)
    end
  end

  private

    def bulletin_params
      params.require(:bulletin).permit(:body).tap do |clean_params|
        clean_params[:body] = Rails::Html::FullSanitizer.new.sanitize(clean_params[:body])
      end
    end

    def correct_user
      @bulletin = current_user.bulletins.find_by(id: params[:id])
      redirect_to root_url if @bulletin.nil?
    end

    def logged_in_user
      #TODO: make into a concern
      unless user_signed_in?
        flash[:danger] = "Please log in."
        redirect_to user_session_path
      end
    end
end
