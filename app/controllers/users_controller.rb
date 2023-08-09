class UsersController < ApplicationController

  def index
    @users = User.all

    respond_to do |format|
      format.html
      format.json { render :json => @users }
      format.xml { render :xml => @users }
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to root_path, status: :see_other
  end
end
