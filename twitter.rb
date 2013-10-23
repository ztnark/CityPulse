require 'rubygems'
require "tweetstream"


 TweetStream.configure do |config|
  config.consumer_key       = "2LLhLNd4A8hzgnAqGQkH7Q"
  config.consumer_secret    = "irPBysCEpUe36Zh6qSD7rKp9fAaZdFMYSZk3McbcHJg"
  config.oauth_token        = "1923959803-jFUE3Qf0NDABDShVPKjUccZgoBChIneWBwOSPxK"
  config.oauth_token_secret = "k4Z8swE7MLeG3lNmy5G1t55NfYcYJ3lMKNSee8UjA"
  config.auth_method        = :oauth
end

TweetStream::Client.new.locations(-87.739906, 41.816073, -87.639656, 41.956139) do |status, client|
  puts "#{status.text}"
  puts "#{status[:user][:screen_name]}"
  puts "#{status[:geo][:coordinates]}"
  puts "#{status[:user][:profile_image_url_https]}"
  puts " ++++++++++++++++++++++++++"
end
