class EventController < WebsocketRails::BaseController

  require 'open-uri'

  def tweets
    # puts "dog"
    TweetStream.configure do |config|
      config.consumer_key       = 'f4VHcj4lCvhg3JpK4sEORQ'
      config.consumer_secret    = 'eVLGY5qoI4e3B2VAt02vHaiXy4yN0wflN2NaaV0iVdI'
      config.oauth_token        = '335415484-ZL0iR1tTWcNWp4Td6QU5GeVVvkBjRUolj8EHlmnX'
      config.oauth_token_secret = 'XXzEIZDrnHS65PlVhHQVB9SMAyjXzeNLMAh1Mhutp6c'
      config.auth_method        = :oauth
    end
    # puts "cats"
    @tweets = []
    TweetStream::Client.new.locations(-87.739906, 41.816073, -87.639656, 41.956139) do |status, client|
      puts "#{status.text}"
      puts "#{status[:user][:screen_name]}"
      puts "#{status[:geo][:coordinates]}"
      puts "#{status[:user][:profile_image_url_https]}"
      puts " ++++++++++++++++++++++++++"
      @tweet = [status[:geo][:coordinates], status.text, status[:user][:screen_name],status[:user][:profile_image_url_https]]
      send_message :tweet_success, @tweet, namespace: :events
    end
  end


  def instagram_fetcher
   # puts "in the instagram fetcher"
    @fetcher ||= Thread.new do
      Instagram.configure do |config|
        config.client_id = "c20b0e71c0ae4c9092810007096d9217"
      end
      instagrams =Instagram.media_search("41.915336","-87.681413",{radius: 4500})
      @instagrams = []
      Instagram.media_search("41.909012","-87.634206",{radius: 4500}).each {|x| instagrams.push(x)}
      Instagram.media_search("41.878107","-87.627490",{radius: 4500}).each {|x| instagrams.push(x)}
      Instagram.media_search("41.882498","-87.668624",{radius: 4500}).each {|x| instagrams.push(x)}
      Instagram.media_search("41.925043","-87.652574",{radius: 4500}).each {|x| instagrams.push(x)}
        counter=0
      instagrams.shuffle.each do |ig|
        p counter += 1
        object = {latitude: ig.to_hash['location']['latitude'],longitude: ig.to_hash['location']['longitude'],url: "<a href=#{ig.to_hash['images']['low_resolution']['url']} target='new'><img src=#{ig.to_hash['images']['low_resolution']['url']} width=100 height=100></a>", }
        string = object.to_s
        time =  Time.now.strftime("%3N")[1..2]
        $redis.hmset("object",time,object)
      end
      p "info"
      time =Time.now.strftime("%3N")[1..2]
      info = $redis.hmget("object",time)
      first = info.first
      eval = eval(first)
      p eval
      send_message :instagram_success, eval, namespace: :events


    end
  end

  def instagram_initialize
    instagram_fetcher
  end


  def trains
    puts "we are in the train fetcher"
    api_key = "345d187dc00d467f9f2d1307b6e4b6c3"
    line = ['red','g','blue','brn','pink','org','p','y']
    trains = open("http://lapi.transitchicago.com/api/1.0/ttpositions.aspx?key=#{api_key}&rt=#{line[0]}&rt=#{line[1]}&rt=#{line[2]}&rt=#{line[3]}&rt=#{line[4]}&rt=#{line[5]}&rt=#{line[6]}&rt=#{line[7]}").first
    @trains = CobraVsMongoose.xml_to_hash(trains)
    send_message :success, @trains, namespace: :events
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
    @eventful = Eventful::API.new 'FwPV5FkjRBWzvzvq',
      :user => 'josephjames890',
      :password => 'veveve122'

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
