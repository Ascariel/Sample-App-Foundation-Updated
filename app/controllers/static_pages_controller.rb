class StaticPagesController < ApplicationController
  def home
    @micropost = current_user.microposts.new() if sign_in?
    @feed_items = current_user.feed.paginate(page: params[:page]) if sign_in?
  end
end
