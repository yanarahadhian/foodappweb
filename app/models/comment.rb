class Comment < ActiveRecord::Base
  belongs_to :item  # owned by one item
  belongs_to :user  # posted by one user

  # validations
  validates :body, :user_id, :item_id, :presence => true

end