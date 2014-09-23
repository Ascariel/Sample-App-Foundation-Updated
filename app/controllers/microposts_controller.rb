class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]
  def create
    @micropost = current_user.microposts.new(microposts_params)
    if @micropost.save
      flash[:success] = 'Micropost created!!'
      redirect_to root_path
    else
      render 'static_pages/home' #doesnt render action
      # redirect_to root_path #also renders actions in home
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_path
  end

  private

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_path if @micropost.nil?
  end

  def microposts_params
    params.require(:micropost).permit(:content)
  end
end
