class Invitation < ActiveRecord::Base
  has_many :childrens, :class_name => "Invitation", :foreign_key => :inviter_id
  belongs_to :parent, :class_name => "Invitation", :foreign_key => :inviter_id

	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validate :ref_key, :on => :create
  validates :first_name, presence: :true, :on => :create
  validates :username, presence: :true, :on => :update
  validates :username, uniqueness: {:message => "Already taken"}, :on => [:update]
  validates_exclusion_of :username, in: %w( tuckerbox ), message: "Can’t use this username"
  validates :email, uniqueness: {:message => "Email has already been taken"}, :on => :create
  scope :username, -> { where("username LIKE '%#{params[:username]}%'")}
	private

  # def subscribe_user_to_mailing_list
  #   SubscribeUserToMailingListJob.perform_later(self)
  # end

  def self.admin_invitation_mail(params)
  	params[:tags_list].split(",").each do |um|
			invite_mailer = InvitationMailer.delay(run_at: 15.seconds.from_now).admin_email_invitation(um, params[:submail], params[:textarea])
		end
  end

  def self.filter(params, state, sort)
    conditions = []
    args = {}

    ["first_name", "status", "email", "username"].each do |k|
      if !params[k.to_sym].blank?
        conditions << "#{k} #{k == "status" ? "=" : "like"} :#{k}"
        args[k.to_sym] = k == "status" ? "#{params[k.to_sym]}" : "%#{params[k.to_sym]}%"
      end
    end
    
    state = "DESC" if state.nil?
    where(conditions.join(" AND "), args)
    .order("#{sort} #{state}")
    .page(params[:page]).per(params[:limit] == "All" ? Invitation.count : params[:limit])
  end

  def self.get_invited_records
    user_names = []

    file_path = Rails.root.join("sample_username.txt")
    File.open(file_path, "r").each_line do |line|
      user_names << line.gsub("\n", "")
    end

    user_names += Invitation.select("username").where("username IS NOT NULL").map(&:username)

    return user_names.shuffle[0..99]
  end

  def ref_key
    rand_text = Array.new(20){[*"A".."Z", *"0".."9"].sample}.join
    gen_base = Base64.encode64("#{rand_text}").first(20)
    self.ref_id = gen_base
  end

  def fullname
    "#{first_name} #{last_name}"
  end
end
