class Store < ActiveRecord::Base
  # manipulating latitude and longitude
  acts_as_mappable :default_units => :kms, :lat_column_name => :latitude, :lng_column_name => :longitude

  # relations
  belongs_to :seller, :foreign_key => 'user_id', :class_name => 'User'    # owns one seller (actually this is user, but renamed for easier access)
  has_and_belongs_to_many :items                                          # every store can sell many different items, vice versa

  # validations
  validates :name, :country, :city, :street, :latitude, :longitude, :location, :presence => true
  has_many :orders
end
