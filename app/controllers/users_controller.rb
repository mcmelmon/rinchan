class UsersController < ApplicationController
  def destroy
  end

  def edit
  end

  def index
  end

  def show
    @user = User.find(params[:id])
    @bulletins = @user.bulletins.paginate(page: params[:page])
  end
end
