class EventController < WebsocketRails::BaseController

  require 'open-uri'

  def tweets
    TweetStream.configure do |config|
      config.consumer_key       = ENV['TWITTER_CONSUMER']
      config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
      config.oauth_token        = ENV['TWITTER_OAUTH_TOKEN']
      config.oauth_token_secret = ENV['TWITTER_SECRET']
      config.auth_method        = :oauth
    end
    # puts "cats"
    @tweets = []
    TweetStream::Client.new.locations(-87.739906, 41.816073, -87.639656, 41.956139) do |status, client|
      # puts "#{status.text}"
      # puts "#{status[:user][:screen_name]}"
      # puts "#{status[:geo][:coordinates]}"
      # puts "#{status[:user][:profile_image_url_https]}"
      # puts " ++++++++++++++++++++++++++"
      @tweet = [status[:geo][:coordinates], status.text, status[:user][:screen_name],status[:user][:profile_image_url_https]]
      if @tweet[0][0] < 42.022686 && @tweet[0][0] > 41.774084 && @tweet[0][1] > -87.957573 && @tweet[0][1] < -87.501812 && @tweet[1][0] != "@"
        send_message :tweet_success, @tweet, namespace: :events
      end
    end
  end

  def test
    puts "we are in test"
    send_message :success, "test", namespace: :events
  end


  def instagram_fetcher
   puts "in the instagram fetcher"
    @fetcher ||= Thread.new do
      counter = 0
        p $redis.hgetall("object").count
      while true
        counter += 1
        counter = 1 if counter > 100
        p counter
        an_instagram = $redis.hmget("object", counter.to_s)
        p an_instagram
        first = an_instagram.first
        if first != nil
          # p an_instagram
          an_instagram = an_instagram.first
          # p an_instagram
          eval = eval(an_instagram)
          # p eval
          send_message :instagram_success, eval, namespace: :events
          sleep (5)
        else
          sleep (2)
          puts "no_photo"
        end
      end
    end
  end



  def instagram_initialize
    instagram_fetcher
  end

  def trains
    train_handler ||= Thread.new do
      while true
      train_data = $redis.hmget("trains", "train_times")
      train = eval(train_data.first)
      send_message :success, train, namespace: :events
      sleep(15)
      end
    end
  end

  def bikes
    bike_handler ||= Thread.new do
      bike_data = $redis.hmget("bikes", "bike_times")
      puts bike_data
      bike = eval(bike_data.first)
      send_message :success, bike, namespace: :events
    end
  end

  def planes
    plane_handler ||= Thread.new do
      while true
      plane_data = $redis.hmget("planes", "plane_times")
      plane = eval(plane_data.first)
      send_message :success, plane, namespace: :events
      sleep(15)
      end
    end
  end

  def eventful_fetcher
    @current_events = []
    Event.all.each do |event|
      if (event.start_time - (Time.now - 18000)) < 900 && (event.start_time - (Time.now - 18000)) > -5400
        @current_events << event
      end
    end
    puts @current_events.length
    send_message :eventful_success, @current_events, namespace: :events
  end

end
