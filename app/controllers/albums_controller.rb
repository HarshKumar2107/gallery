class AlbumsController < ApplicationController

  before_action :authenticate_user!
  
  def index
    @unpublished_albums = current_user.albums.unpublished.order(created_at: :desc)
    @published_albums = current_user.albums.published.order(created_at: :desc)
  end

  def show
    @album = Album.find(params[:id])
  end

  def new
    @album = current_user.albums.build
  end

  def create
    @album = current_user.albums.build(album_params)

    if @album.save
      redirect_to @album
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      redirect_to @album
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    redirect_to root_path, status: :see_other
  end

  def purge_img
    image = ActiveStorage::Attachment.find(params[:id])
    image.purge
    redirect_back(fallback_location: root_path)
  end

  private
    def album_params
      params.require(:album).permit(:title, :description, :tagged, :published, :cover, images: [])
    end

end
