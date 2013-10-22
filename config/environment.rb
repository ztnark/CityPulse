# Load the Rails application.
require File.expand_path('../application', __FILE__)

redis_config = YAML.load_file(Rails.root + 'config/redis.yml')[Rails.env] 

if redis_config 
  $redis = Redis.new(host: redis_config['host'], port: redis_config['port']) 
end 

# Initialize the Rails application.
Chicageaux::Application.initialize!
