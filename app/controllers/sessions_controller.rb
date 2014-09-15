class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email: params[:sessions][:email].downcase)
    if user && user.authenticate(params[:sessions][:password])
      sign_in(user)
      redirect_back_or user
    else
      flash.now[:error] = "Unable to login due to some Password/Email error!"
      render 'new'
    end
  end
  def destroy
    sign_out
    redirect_to root_path
  end
end
