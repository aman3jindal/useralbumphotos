class PhotosController < ApplicationController
  before_action :set_photo, only: %i[ show edit update destroy ]
  def new
    @album = Album.find(params[:album_id])
    @photo = Photo.new
  end
  def create
    @album = Album.find(params[:album_id])
    @photo = @album.photos.build(photo_params)

    if @photo.save
      redirect_to root_path
    else
      render 'new'
    end
  end
  def index
    @album = Album.find(params[:album_id])
    @photos = Photo.where(album_id: @album.id).find_each
  end
  def show
  end
  def edit
  end
  def update
    if @photo.update(photo_params)
      redirect_to user_albums_path(current_user,@album)
    else
      render 'edit'
    end
  end
  def destroy
    @photo.destroy
    redirect_to user_album_photos_path
  end
  def delete_user_album_photos
    attachment = ActiveStorage::Attachment.find(params[:id])
    attachment.purge
    redirect_back(fallback_location: user_album_photos_path)
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_photo
    @album = Album.find(params[:album_id])
    @photo = @album.photos.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def photo_params
    params.require(:photo).permit( :tag,user_album_photos: [])
  end
end
