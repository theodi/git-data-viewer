if ENV['AIRBRAKE_GIT_VIEWER_KEY']
  require 'airbrake'

  Airbrake.configure do |config|
    config.api_key = ENV['AIRBRAKE_GIT_VIEWER_KEY']
  end
end