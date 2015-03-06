Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_AP_ID'], ENV['FACEBOOK_APP_SECRET']
end
