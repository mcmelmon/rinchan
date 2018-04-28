class BulletinsController < ApplicationController
  def create
    @bulletin = current_user.bulletins.build(bulletin_params)
    if @bulletin.save
      flash[:success] = "Post created!"
      redirect_to user_path(current_user)
    else
      redirect_to root_path
    end
  end

  def destroy
  end

  def edit
  end

  def update
  end

  private

    def bulletin_params
      params.require(:bulletin).permit(:body, :title)
    end
end
