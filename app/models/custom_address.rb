class CustomAddress < ActiveRecord::Base
  belongs_to :user  # owned by single user
  has_many :orders
end
