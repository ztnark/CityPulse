class Aggregator

  @@query = 17

  def self.trains
  trains_api = "345d187dc00d467f9f2d1307b6e4b6c3"
    line = ['red','g','blue','brn','pink','org','p','y']
    trains = open("http://lapi.transitchicago.com/api/1.0/ttpositions.aspx?key=#{trains_api}&rt=#{line[0]}&rt=#{line[1]}&rt=#{line[2]}&rt=#{line[3]}&rt=#{line[4]}&rt=#{line[5]}&rt=#{line[6]}&rt=#{line[7]}").first
    trains_hash = CobraVsMongoose.xml_to_hash(trains)
    train_times = "train_times"
    $redis.hmset("trains", train_times, trains_hash)
    p "+++++++++++++++++++ TRAINS:    this is a new request    +++++++++++++++++++++++++"
    p Time.now
    p "+++++++++++++++++++ TRAINS:    this is a new request    +++++++++++++++++++++++++"
  end

  def self.instagram
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
      # p counter += 1
      object = {latitude: ig.to_hash['location']['latitude'],longitude: ig.to_hash['location']['longitude'],url: "<a href=#{ig.to_hash['images']['low_resolution']['url']} target='new'><img src=#{ig.to_hash['images']['low_resolution']['url']} width=100 height=100></a>", }
      string = object.to_s
      time =  Time.now.strftime("%3N")[1..2]
      $redis.hmset("object" ,time ,object)
    end
    p "+++++++++++++++++    this is a new Instagram request    +++++++++++++++++++++++"
    p Time.now
    p "+++++++++++++++++    this is a new Instagram request    +++++++++++++++++++++++"
  end

  def self.eventful
    p "+++++++++++++++++++     this is a new eventful request    +++++++++++++++++++++++++"
    p Time.now
    eventful = Eventful::API.new 'FwPV5FkjRBWzvzvq',
                                :user => 'josephjames890',
                                :password => 'veveve122'
    puts 'eventful API initiated'

    first_query = eventful.call 'events/search',
      :location    => '41.8819, -87.6278',
      :within      => 6,
      :date        => Date.today,
      :count_only  => true
    total_events = first_query['total_items']
    puts "#{total_events} events in Chicago today."

    total_queries = total_events / 100
    if total_events % 100 > 0
      total_queries += 1
    end

    2.times do |query|
    # total_queries.times do |query|
      results = eventful.call 'events/search',
        :location    => 'Chicago',
        :date        => Date.today,
        :sort_order  => 'popularity',
        :page_size   => 100,
        :page_number => query + 1
      results['events']['event'].each { |event|
        Event.create( title:         event['title'],
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
      sleep(120)
    end
    p "+++++++++++++++++++     this is a new eventful request    +++++++++++++++++++++++++"
  end

  # def self.eventful_queries
  #   puts "Hey there"
  #   puts @@query
  #   # eventful = Eventful::API.new 'FwPV5FkjRBWzvzvq',
  #   #                             :user => 'josephjames890',
  #   #                             :password => 'veveve122'
  #   if query <= total_queries
  #     results = eventful.call 'events/search',
  #       :location    => 'Chicago',
  #       :date        => Date.today,
  #       :sort_order  => 'popularity',
  #       :page_size   => 100,
  #       :page_number => @@query
  #     results['events']['event'].each { |event|
  #       Event.create( title:         event['title'],
  #                     venue_name:    event['venue_name'],
  #                     latitude:      event['latitude'],
  #                     longitude:     event['longitude'],
  #                     start_time:    event['start_time'],
  #                     stop_time:     event['stop_time'],
  #                     eventful_id:   event['id'],
  #                     thumb:         event['thumb'],
  #                     url:           event['url'],
  #                     city_name:     event['city_name'],
  #                     venue_address: event['venue_address'],
  #                     region_abbr:   event['region_abbr'],
  #                     postal_code:   event['postal_code'] )
  #     }
  #     query += 1
  #   end
  #   puts 'Hi'
  #   puts Event.count
  # end


end

