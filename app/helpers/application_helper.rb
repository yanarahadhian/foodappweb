module ApplicationHelper

  def avatar_user(user)
    unless user.images.blank?
      user.images.each do |image|
        if image.flag == 'avatar'
          return image.storage.thumb.url
        end
      end
    else
      return 'profile-pic.jpg'
    end
  end

  def background_user(user)
    unless user.images.blank?
      user.images.each do |image|
        if image.flag == 'background'
          return image.storage.thumb.url
        end
      end
    else
      return 'assets/cover.png'
    end
  end

  def item_image_user(item)
    unless item.images.blank?
      item.images.each do |image|
        # if image.flag == "item"
          return image.storage.thumb.url
        # end
      end
    else
      return 'default-food.jpg'
    end
  end

  def edit_item_image_user(item, index)
    _arr_ret = []
    unless item.images.blank?
      image_url = item.images.order("created_at DESC")[index]
      if image_url.present?
        _arr_ret << image_url.storage.thumb.url
        _arr_ret << (hidden_field_tag "image_detail[]", "#{item.images.order("created_at DESC")[index].storage.to_s.split("/").last}##{item.images.order("created_at DESC")[index].id}#false")
        _arr_ret << image_url.id
      else
        _arr_ret << 'default-food.jpg'
      end
    else
      _arr_ret << 'default-food.jpg'
    end
    return _arr_ret
  end

  def following(user)
    following = Follower.where("user_follower_id = ? ", user.id)
    return following.count
  end

  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end

  def visitor_country
    country_location = ["Malaysia", "Australia", "Indonesia", "Singapore"]
    visitor_ip = request.remote_ip
    vis_geocode = Geocoder.search(visitor_ip)

    if country_location.include? vis_geocode.first.country
       vis_geocode.first.country
    else
      # if we found Google Geocoding API error : over query limit
      # we should handle the location by set the default location to Indonesia
      begin
        malaysia = Geocoder.search("Malaysia")
        australia = Geocoder.search("Australia")
        indonesia = Geocoder.search("Indonesia")
        singapore = Geocoder.search("Singapore")

        distance_to_malaysia = Geocoder::Calculations.distance_between([malaysia.first.latitude, malaysia.first.longitude],[vis_geocode.first.latitude, vis_geocode.first.longitude])
        distance_to_australia = Geocoder::Calculations.distance_between([australia.first.latitude, australia.first.longitude],[vis_geocode.first.latitude, vis_geocode.first.longitude])
        distance_to_indonesia = Geocoder::Calculations.distance_between([indonesia.first.latitude, indonesia.first.longitude],[vis_geocode.first.latitude, vis_geocode.first.longitude])
        distance_to_singapore = Geocoder::Calculations.distance_between([singapore.first.latitude, singapore.first.longitude],[vis_geocode.first.latitude, vis_geocode.first.longitude])

        get_min_latlong = [distance_to_malaysia, distance_to_singapore, distance_to_indonesia, distance_to_australia].min
        location = ""

        if (distance_to_australia == get_min_latlong)
          location = "Australia"
        elsif (distance_to_malaysia == get_min_latlong)
          location = "Malaysia"
        elsif (distance_to_singapore == get_min_latlong)
          location = "Singapore"
        elsif (distance_to_indonesia == get_min_latlong)
          location = "Indonesia"
        else
          location = "Malaysia"
        end
      rescue
        location = DEFAULT_LOCATION
      end

      return location
    end
  end

  # def sortable(column, title = nil)
  #   title ||= column.titleize
  #   css_class = column == sort_column ? "current #{sort_direction}" : nil
  #   direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
  #   link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  # end

  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end
  
end
