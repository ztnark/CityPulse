require 'open-uri'
require 'tweetstream'


puts "TWEETS INITIALIZED"
TweetStream.configure do |config|
  config.consumer_key       = ENV['TWITTER_CONSUMER']
  config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
  config.oauth_token        = ENV['TWITTER_OAUTH_TOKEN']
  config.oauth_token_secret = ENV['TWITTER_SECRET']
  config.auth_method        = :oauth
end

@tweets = []

TweetStream::Daemon.new.locations(-87.739906, 41.816073, -87.639656, 41.956139) do |status, client|

  @tweet = [status[:geo][:coordinates], status.text, status[:user][:screen_name],status[:user][:profile_image_url_https]]
  if @tweet[0][0] < 42.022686 && @tweet[0][0] > 41.774084 && @tweet[0][1] > -87.957573 && @tweet[0][1] < -87.501812 && @tweet[1][0] != "@"
    $redis.hmset("tweets", "recent_tweet", @tweet.to_s)
  end
end

