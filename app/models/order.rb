class Order < ActiveRecord::Base
	belongs_to :item
	belongs_to :user
	belongs_to :store
	belongs_to :custom_address

	enum :status => [:pending, :confirm, :complete]
	enum :rating => [:love, :wide_smile, :smile, :flat, :nope, :unrated]

	def self.get_count_rating(type)
		count_rating = 0
		self.all.each do |rat|
			count_rating += 1 if rat.rating == type
		end
		return count_rating
	end

	def self.filter(params, state, sort)
    conditions = []
    args = {}
    qry = {
    	"table" => {
    		"buyer_name" => "users", "seller_name" => "item_user", "status" => "orders", "price_from" => "orders", "price_to" => "orders"
    	},
    	"field" => {
    		"buyer_name" => "full_name", "seller_name" => "full_name", "status" => "status", "price_from" => "subtotal", "price_to" => "subtotal"
    	}
    }

    ["buyer_name", "seller_name", "status", "price_from", "price_to"].each do |k|
      if !params[k.to_sym].blank?
        if ["price_from", "price_to"].include?(k)
        	conditions << "#{qry["table"][k]}.#{qry["field"][k]} #{k == "price_from" ? ">=" : "<="} :#{k}"
        else
        	conditions << "#{qry["table"][k]}.#{qry["field"][k]} #{k == "status" ? "=" : "like"} :#{k}"
        end
      	args[k.to_sym] = ["price_from", "price_to", "status"].include?(k) ? "#{params[k.to_sym]}" : "%#{params[k.to_sym]}%"
      end
    end

    joins(:user, :item, "LEFT JOIN users item_user on item_user.id = items.user_id")
    .order("#{sort} #{state}")
    .page(params[:page]).per(params[:limit] == "All" ? Order.count : params[:limit])
    .where(conditions.join(" AND "), args)
  end

end
