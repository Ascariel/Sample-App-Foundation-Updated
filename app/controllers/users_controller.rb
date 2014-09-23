class UsersController < ApplicationController

  before_action :signed_in_user, only: [:index, :edit, :update] #added show, to stop peeping other users profiles when signed in
  before_action :correct_user, only: [:edit, :update]
  before_action :admin, only: [:destroy]

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create 
    @user = User.create(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to our Tweeter App"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id]) #Can be ommitted beceause its done in the before action correct user method
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile Updated"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end
  def destroy 
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_path
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  #Before Actions

  def admin
    redirect_to root_path unless current_user.admin?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end



end
