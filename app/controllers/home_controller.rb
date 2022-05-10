class HomeController < ApplicationController
  def index
    if user_signed_in?
    	@q = Album.published.order(created_at: :desc).ransack(params[:q])
    	@q1 = current_user.albums.unpublished.order(created_at: :desc).ransack(params[:q])
      @published_albums = @q.result
      @unpublished_albums = @q1.result
  	else
  	  @q = Album.published.order(created_at: :desc).ransack(params[:q])
  	  @published_albums = @q.result
  	end
  end
end
