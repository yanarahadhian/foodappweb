class ItemLike < ActiveRecord::Base
  belongs_to :user  # this is act like join table, connecting 2 spaces
  belongs_to :item  # this is too
end
