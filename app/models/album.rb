class Album < ApplicationRecord
  belongs_to :user
  has_many  :photos, dependent: :delete_all
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10 }
end
