class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  # mount_uploader :storage, ImageUploader

  has_many :stores, :dependent => :destroy
  has_many :items, :dependent => :destroy
  has_many :images, :dependent => :destroy
  has_many :item_likes, :dependent => :destroy
  has_many :liked_items, :through => :item_likes, :source => :item
  has_many :comments, :foreign_key => 'user_id', :dependent => :destroy
  has_many :custom_addresses, :dependent => :destroy
  has_many :followers, :dependent => :destroy
  has_many :orders, :dependent => :destroy
  has_many :reports, :as => :report, :dependent => :destroy
  has_one :quick_blox, :dependent => :destroy
  paginates_per 25
  before_save :permalink
  has_secure_password
  acts_as_follower
  acts_as_followable
  validates :email, uniqueness: true
  accepts_nested_attributes_for :reports, allow_destroy: :true, :reject_if => proc {|obj| obj.blank? }

  def permalink
  	self.permalink = self.full_name.split(" ").join(".").downcase
  end

  def to_param
  	permalink
  end

  def avatar=(image)
    self.images.find_or_create_by(:flag => 'avatar').update(:storage => image) rescue nil
  end

  # helper method to set background image storage
  def background=(image)
    self.images.find_or_create_by(:flag => 'background').update(:storage => image) rescue nil
  end

  # check is reset password token valid
  def is_reset_token_valid?(qwi_params)
    !self.reset_password_digest.nil? &&
    !self.reset_password_expiry.nil? &&
    (Time.now < self.reset_password_expiry + 7.hours) &&
    (BCrypt::Password.new(self.reset_password_digest) == qwi_params)
  end

  def request_reset_password
    # token lifetime
    token_lifetime = 70.minutes
    expired_at = DateTime.now + token_lifetime

    # generating token
    token = SecureRandom.urlsafe_base64(47) + Digest::MD5.hexdigest(expired_at.to_i.to_s)
    # reset_link = url_foodappweb_absolute('reset_password?qwi=' + token + '&moch=' + self.id.to_s)

    # update database
    encrypted = BCrypt::Password.create(token)
    self.update(:reset_password_digest => encrypted, :reset_password_expiry => expired_at)

    # send email
    # EmailSender.reset_password_link(self.full_name, self.email, reset_link).deliver_later
  end

  def self.filter(params, state, sort)
    conditions = []
    args = {}

    ["full_name", "email", "username", "status"].each do |k|
      if !params[k.to_sym].blank?
        conditions << "#{k} LIKE :#{k}"
        args[k.to_sym] = "%#{params[k.to_sym]}%"
      end
    end
    where(conditions.join(" AND "), args)
    .order("#{sort} #{state}")
    .page(params[:page]).per(params[:limit] == "All" ? User.count : params[:limit])
  end

end
