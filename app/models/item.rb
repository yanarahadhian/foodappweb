class Item < ActiveRecord::Base
  # mount_uploader :storage, ImageUploader
  
  has_many :images, :dependent => :destroy                                # item photos
  has_many :item_likes, :dependent => :destroy                            # user food likes will saved in this table
  has_many :liked_by, :through => :item_likes, :source => :user           # rename the interface for easier access
  has_many :comments, :dependent => :destroy                              # relation to all comments for an item
  belongs_to :item_category                                               # owns one category
  belongs_to :user                                                        # owns one category
  belongs_to :seller, :foreign_key => 'user_id', :class_name => 'User'    # owns one seller (actually this is user, but renamed for easier access)
  has_and_belongs_to_many :stores                                        # every item can be sold in many different stores, vice versa
  has_many :orders
  has_many :reports, :as => :report, :dependent => :destroy
  has_many :item_impressions, :dependent => :destroy
  has_many :item_favourites, :dependent => :destroy

  # validation
  validates :name, :price, :presence => true
  accepts_nested_attributes_for :images, :allow_destroy => true

  # scope for querying search function
  scope :search_by_name_from_targeted_country, ->(name, country) {
    by_name = name.nil? ? '' : name
    by_country = country.nil? ? '' : country
    joins(:seller).where('users.country LIKE ? AND items.name LIKE ?', "%#{by_country}%", "%#{by_name}%")
  }
  
  before_save :permalink
  accepts_nested_attributes_for :reports, allow_destroy: :true, :reject_if => proc {|obj| obj.blank? }

  def permalink
    self.permalink = self.name.split(" ").join(".").downcase
  end

  def to_param
    permalink
  end

  def image_items=(image)
    self.images.find_or_create_by(:flag => 'item').update(:storage => image) rescue nil
  end

  def destroy_images(image_detail)
    arr_image_id = []
    image_detail.each do |im|
      stat = im.split("#")[2]
      if stat == "true"
        arr_image_id << im.split("#")[1]
      end
    end
    unless arr_image_id.blank?
      self.images.where("id in (#{arr_image_id.join(',')})").destroy_all
    end
  end

  def self.filter(params, state, sort)
    conditions = []
    args = {}

    ["item_category_id", "name", "username", "status"].each do |k|
      if !params[k.to_sym].blank?
        conditions << "#{k == "username" ? "users" : "items"}.#{k} #{k == "item_category_id" ? "=" : "like"} :#{k}"
        args[k.to_sym] = k == "item_category_id" ? "#{params[k.to_sym]}" : "%#{params[k.to_sym]}%"
      end
    end

    joins(:user, :item_category)
    .order("#{sort} #{state}")
    .page(params[:page]).per(params[:limit] == "All" ? Item.count : params[:limit])
    .where(conditions.join(" AND "), args)
  end

end
