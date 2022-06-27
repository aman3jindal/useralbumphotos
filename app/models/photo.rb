class Photo < ApplicationRecord
  belongs_to :album
  has_many_attached :user_album_photos
end
