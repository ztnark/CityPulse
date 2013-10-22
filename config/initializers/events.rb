WebsocketRails.setup do |config|
   config.standalone = true
   config.redis_options = {:host => 'your.host', :port => '6379'}
end


