class AlbumsController < ApplicationController
  before_action :authenticate_user!
  def create
    @album = current_user.albums.build(album_params)
    if @album.save
      redirect_to new_user_album_photo_path(current_user,@album)
    else
      render 'new'
    end
  end
  def index
    @albums = Album.where(user_id: current_user).find_each
  end
  def show
    @album = Album.find(params[:id])
  end
  def new
   @album = Album.new
  end
  def edit
    @album = Album.find(params[:id])
  end
  def update
    @user = User.find(params[:user_id])
    @album = @user.albums.find(params[:id])
    if @album.update(album_params)
      redirect_to user_albums_path(@user)
    else
      render 'edit'
    end
  end
  def destroy
    @user = User.find(params[:user_id])
    @album = @user.albums.find(params[:id])
    @album.destroy
  
    redirect_to user_albums_path, status: :see_other
  end
  private
    def album_params
      params.require(:album).permit(:name, :description)
    end
end