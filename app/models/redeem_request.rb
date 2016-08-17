class RedeemRequest < ActiveRecord::Base
  belongs_to :user
  has_one :wallet_transaction, :dependent => :destroy

  enum :status => [:pending, :paid]

  # override on paid method to allow us update wallet transaction
  def paid!
    self.wallet_transaction.update_columns(:is_holded => false)
    super
  end

  def self.filter(params, state, sort)
    conditions = []
    args = {}

    ["status"].each do |k|
      if !params[k.to_sym].blank?
        conditions << "#{k} #{k == "status" ? "=" : "like"} :#{k}"
        args[k.to_sym] = k == "status" ? "#{params[k.to_sym]}" : "%#{params[k.to_sym]}%"
      end
    end
    
    state = "DESC" if state.nil?
    where(conditions.join(" AND "), args)
    .order("#{sort} #{state}")
    .page(params[:page]).per(params[:limit] == "All" ? RedeemRequest.count : params[:limit])
  end
end