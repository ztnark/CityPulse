class EventController < WebsocketRails::BaseController

  require 'open-uri'
  before_filter do
    puts "an event handled by this controller was called"
  end
  # before_filter do
  #   puts "an event handled by this controller was called"
  # end

  def dispatch
    send_message :success, "hello from the server", namespace: :events
  end

  def tweets
    TweetStream.configure do |config|
      config.consumer_key       = 'f4VHcj4lCvhg3JpK4sEORQ'
      config.consumer_secret    = 'eVLGY5qoI4e3B2VAt02vHaiXy4yN0wflN2NaaV0iVdI'
      config.oauth_token        = '335415484-ZL0iR1tTWcNWp4Td6QU5GeVVvkBjRUolj8EHlmnX'
      config.oauth_token_secret = 'XXzEIZDrnHS65PlVhHQVB9SMAyjXzeNLMAh1Mhutp6c'
      config.auth_method        = :oauth
    end
    @tweets = []
    TweetStream::Client.new.locations(-87.739906, 41.816073, -87.639656, 41.956139) do |status, client|
      puts "#{status.text}"
      puts "#{status[:user][:screen_name]}"
      puts "#{status[:geo][:coordinates]}"
      puts " ++++++++++++++++++++++++++"
      @tweet = [status[:geo][:coordinates], status.text, status[:user][:screen_name]]
      send_message :tweet_success, @tweet, namespace: :events
    end

  end


  def instagram
    @t ||= Thread.new do
    Instagram.configure do |config|
      config.client_id = "c20b0e71c0ae4c9092810007096d9217"
    end
      instagrams =Instagram.media_search("41.915336","-87.681413",{radius: 4500})

      @instagrams = []
      Instagram.media_search("41.909012","-87.634206",{radius: 4500}).each {|x| instagrams.push(x)}
      Instagram.media_search("41.878107","-87.627490",{radius: 4500}).each {|x| instagrams.push(x)}
      Instagram.media_search("41.882498","-87.668624",{radius: 4500}).each {|x| instagrams.push(x)}
      Instagram.media_search("41.925043","-87.652574",{radius: 4500}).each {|x| instagrams.push(x)}

      instagrams.shuffle.each do |ig|
        @instagrams << {latitude: ig.to_hash['location']['latitude'],
                        longitude: ig.to_hash['location']['longitude'],
                        url: "<a href=#{ig.to_hash['images']['low_resolution']['url']} target='new'><img src=#{ig.to_hash['images']['low_resolution']['url']} width=100 height=100></a>",
                        # text: ig.caption.text
                       }

      end
      while @instagrams.length > 0
        send_message :success, @instagrams.pop, namespace: :events
        sleep 10
      end
    end


   def instagram_fetcher
    puts "instragram coming"
   Instagram.configure do |config|
      config.client_id = "c20b0e71c0ae4c9092810007096d9217"
    end
   puts "request has been made"
   puts instagrams = Instagram.media_search("41.8929153","-87.6359125")
   @instagrams = []
   instagrams.each do |ig|
     @instagrams << {latitude: ig.to_hash['location']['latitude'],
                   longitude: ig.to_hash['location']['longitude'],
                   url: ig.to_hash['images']['low_resolution']['url'],
                   # text: ig.to_hash['caption']['text']
                 }
   end
   $redis.set("instagrams", @instagrams)
  end


  def instagram
      instagram_fetcher
      # puts $redis.get("instagrams")
      grams = eval($redis.get("instagrams")).pop
      gram = grams.to_json
      p gram
      send_message :instagram_success, gram, namespace: :events
  end

  def trains

      puts "we are in the train fetcher"
      api_key = "345d187dc00d467f9f2d1307b6e4b6c3"
      line = ['red','g','blue','brn','pink','org','p','y']
      puts "Here we go"
      trains = open("http://lapi.transitchicago.com/api/1.0/ttpositions.aspx?key=#{api_key}&rt=#{line[0]}&rt=#{line[1]}&rt=#{line[2]}&rt=#{line[3]}&rt=#{line[4]}&rt=#{line[5]}&rt=#{line[6]}&rt=#{line[7]}").first
      puts "Here we are"
      @trains = CobraVsMongoose.xml_to_hash(trains)
      # puts trains
      send_message :success, @trains, namespace: :events
  end





    # Instagram.configure do |config|
    #   config.client_id = "c20b0e71c0ae4c9092810007096d9217"
    # end

    # running = true
    # while running
    #   instagrams =Instagram.media_search("41.8929153","-87.6359125")
    #   @instagrams = []
    #   instagrams.each do |ig|
    #     @instagrams << {latitude: ig.to_hash['location']['latitude'],
    #                     longitude: ig.to_hash['location']['longitude'],
    #                     url: ig.to_hash['images']['low_resolution']['url'],
    #                     # text: ig.to_hash['caption']['text']
    #                    }
    #   end
    #   sleep 1
    #   send_message :success, @instagrams, namespace: :events
    #   running = false
    # end
end
