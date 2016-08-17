class Image < ActiveRecord::Base
  mount_uploader :storage, ImageUploader

  # relations
  belongs_to :item  # can be owned by item (as food item photo)
  belongs_to :user  # can be owned by user (as background or avatar image)

  validates :storage, :presence => true
end
