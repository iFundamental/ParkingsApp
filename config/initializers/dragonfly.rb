require 'dragonfly'
require 'dragonfly/s3_data_store'
# Configure
Dragonfly.app.configure do
  plugin :imagemagick
  secret "1a42a77e575c285d392b3c2b5a5d6bb601e34c73a49bad0c6773fe48e1389089"

  url_format "/media/:job/:name"
  convert_command = "/usr/local/bin/convert"

    
  if Rails.env.test? || Rails.env.development?
    datastore :file,
    root_path: Rails.root.join('public/system/dragonfly', Rails.env),
    server_root: Rails.root.join('public')
  else
    datastore :s3,
              bucket_name: 'bootcamp6-salza80',
              access_key_id: ENV['s3_access_key_id'],
              secret_access_key: ENV['s3_secret_access_key']
  end
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
