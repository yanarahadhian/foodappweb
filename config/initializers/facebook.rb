if Rails.env.production?
  FB_FEED_PICTURE_URL = "http://www.tuckerbox.es/assets/tuckbox_logo_feed.png"
  FB_APP_ID = "205327429808878"
else
  FB_FEED_PICTURE_URL = "http://foodapp.stagingapps.net/assets/tuckbox_logo_feed.png"
  FB_APP_ID = "392354340775117"
end