# Load the Rails application.
require File.expand_path('../application', __FILE__)

redis_config = YAML.load_file(Rails.root + 'config/redis.yml')[Rails.env] 


# Initialize the Rails application.
Chicageaux::Application.initialize!
