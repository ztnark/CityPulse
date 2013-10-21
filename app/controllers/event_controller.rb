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
      send_message :tweet_success, @tweet, namespace: :events
    end
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
          sleep (1)
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
      sleep(5)
      end
    end
  end


  def daily_queries(queries)
    @today_events = []
    queries.times { |page|
      if page > 9 && page % 10 == 0
        sleep(15)
      end
      results = @eventful.call 'events/search',
        :location    => '41.8819, -87.6278',
        :within      => 6,
        :date        => Date.today,
        :sort_order  => 'popularity',
        :sort_direction => 'descending',
        :page_size   => 100,
        :page_number => page + 1

      results['events']['event'].each { |event|
        @today_events << Event.create( title:         event['title'],
                                       venue_name:    event['venue_name'],
                                       latitude:      event['latitude'],
                                       longitude:     event['longitude'],
                                       start_time:    event['start_time'],
                                       stop_time:     event['stop_time'],
                                       eventful_id:   event['id'],
                                       thumb:         event['thumb'],
                                       url:           event['url'],
                                       city_name:     event['city_name'],
                                       venue_address: event['venue_address'],
                                       region_abbr:   event['region_abbr'],
                                       postal_code:   event['postal_code'] )
      }
      puts @today_events.length
    }
    @today_events
  end

  def eventful_fetcher
    puts "We are in events"
    @eventful = Eventful::API.new ENV['EVENTFUL_KEY'],
      :user => ENV['USER_NAME'],
      :password => ENV['PASSWORD']

    # @today_events = Event.all.each { |event| @today_events << event }
    # if @today_events.length < 1
    # total_events_today
    # number_of_queries?
    daily_queries(1)
    # end
    @current_events = []
    @today_events.each { |event| @current_events << event if (event.start_time - (Time.now - 18000)) < 900 && (event.start_time - (Time.now - 18000)) > -7200 }

    puts @today_events.length
    puts @current_events.length

    send_message :success, @current_events, namespace: :events
  end

end
