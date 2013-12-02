class Aggregator

  def self.trains
    40.times do
    trains_api = ENV['TRAINS_KEY']
    line = ['red','g','blue','brn','pink','org','p','y']
    trains_request = open("http://lapi.transitchicago.com/api/1.0/ttpositions.aspx?key=#{trains_api}&rt=#{line[0]}&rt=#{line[1]}&rt=#{line[2]}&rt=#{line[3]}&rt=#{line[4]}&rt=#{line[5]}&rt=#{line[6]}&rt=#{line[7]}").first
    trains_hash = CobraVsMongoose.xml_to_hash(trains_request)
    $redis.hmset("trains", "train_times", trains_hash)
    p "+++++++++++++++++++ TRAINS:    this is a new request    +++++++++++++++++++++++++"
    p Time.now
    sleep(15)
   end
  end

  def self.planes
    8.times do
      planes_request = open("https://api.flightstats.com/flex/flightstatus/rest/v2/xml/airport/tracks/ORD/arr?appId=1962933e&appKey=a64909be7ac34351f562edd1acec0fba&includeFlightPlan=false&maxPositions=2&maxFlights=10").read()
      planes_hash = CobraVsMongoose.xml_to_hash(planes_request)
      $redis.hmset("planes", "plane_times", planes_hash)
      planes_request2 = open("https://api.flightstats.com/flex/flightstatus/rest/v2/xml/airport/tracks/MDW/arr?appId=1962933e&appKey=a64909be7ac34351f562edd1acec0fba&includeFlightPlan=false&maxPositions=2&maxFlights=10").read()
      planes_hash2 = CobraVsMongoose.xml_to_hash(planes_request2)
      $redis.hmset("planes2", "plane_times2", planes_hash2)
      p "+++++++++++++++++++ PLANES:    this is a new request    +++++++++++++++++++++++++"
      p Time.now
      p "+++++++++++++++++++ PLANES:    this is a new request    +++++++++++++++++++++++++"
          # send_message :success, train[:ctatt], namespace: :events
      sleep(15)
    end
  end

  def self.instagram
    duration= Time.now
    Instagram.configure do |config|
      config.client_id = ENV['INSTAGRAM']
    end
    instagrams = []
    Instagram.media_search("41.881732","-87.63073",{radius: 4500, count: 10}).each {|x| instagrams.push(x)}
    Instagram.media_search("41.864028","-87.630301",{radius: 4500, count: 10}).each {|x| instagrams.push(x)}
    Instagram.media_search("41.882307","-87.649269",{radius: 4500, count: 10}).each {|x| instagrams.push(x)}
    counter=0
    instagrams.shuffle.each do |ig|
      counter += 1
      object = {latitude: ig.to_hash['location']['latitude'],longitude: ig.to_hash['location']['longitude'],url: "<a href=#{ig.to_hash['images']['low_resolution']['url']} target='new'><img src=#{ig.to_hash['images']['low_resolution']['url']} width=100 height=100></a>", }
      string = object.to_s
      # time =  Time.now.strftime("%3N")[1..2]
      $redis.hmset("object", counter.to_s, object)
    end
    sleep(105)
    p "first"
    instagrams = []
    Instagram.media_search("41.892019","-87.652874",{radius: 4500, count: 11}).each {|x| instagrams.push(x)}
    Instagram.media_search("41.901219","-87.645063",{radius: 4500, count: 11}).each {|x| instagrams.push(x)}
    Instagram.media_search("41.934366","-87.646093",{radius: 4500, count: 11}).each {|x| instagrams.push(x)}
    counter=0
    instagrams.shuffle.each do |ig|
      counter += 1
      object = {latitude: ig.to_hash['location']['latitude'],longitude: ig.to_hash['location']['longitude'],url: "<a href=#{ig.to_hash['images']['low_resolution']['url']} target='new'><img src=#{ig.to_hash['images']['low_resolution']['url']} width=100 height=100></a>", }
      string = object.to_s
      # time =  Time.now.strftime("%3N")[1..2]
      $redis.hmset("object", counter.to_s, object)
    end
    sleep(115)
    p "second"
    instagrams = []
    Instagram.media_search("41.894703","-87.632875",{radius: 4500, count: 11}).each {|x| instagrams.push(x)}
    Instagram.media_search("41.899686","-87.660427",{radius: 4500, count: 11}).each {|x| instagrams.push(x)}
    Instagram.media_search("41.913292","-87.649527",{radius: 4500, count: 11}).each {|x| instagrams.push(x)}
    counter=0
    instagrams.shuffle.each do |ig|
      counter += 1
      object = {latitude: ig.to_hash['location']['latitude'],longitude: ig.to_hash['location']['longitude'],url: "<a href=#{ig.to_hash['images']['low_resolution']['url']} target='new'><img src=#{ig.to_hash['images']['low_resolution']['url']} width=100 height=100></a>", }
      string = object.to_s
      $redis.hmset("object", counter.to_s, object)
    end

    sleep(105)
    p "third"
    instagrams = []

    Instagram.media_search("41.845616","-87.62043",{radius: 4500, count: 11}).each {|x| instagrams.push(x)}
    Instagram.media_search("41.85738","-87.663774",{radius: 4500, count: 11}).each {|x| instagrams.push(x)}
    Instagram.media_search("41.839989","-87.638712",{radius: 4500, count: 11}).each {|x| instagrams.push(x)}
    Instagram.media_search("41.883073","-87.672958",{radius: 4500, count: 11}).each {|x| instagrams.push(x)}
    counter=0
    instagrams.shuffle.each do |ig|
      counter += 1
      object = {latitude: ig.to_hash['location']['latitude'],longitude: ig.to_hash['location']['longitude'],url: "<a href=#{ig.to_hash['images']['low_resolution']['url']} target='new'><img src=#{ig.to_hash['images']['low_resolution']['url']} width=100 height=100></a>", }
      string = object.to_s
      $redis.hmset("object", counter.to_s, object)
    end

    sleep(80)
    p "fourth"
    instagrams = []

    Instagram.media_search("41.849772","-87.63545",{radius: 4500, count: 11}).each {|x| instagrams.push(x)}
    Instagram.media_search("41.891572","-87.635193",{radius: 4500, count: 11}).each {|x| instagrams.push(x)}
    Instagram.media_search("41.868758","-87.673388",{radius: 4500, count: 11}).each {|x| instagrams.push(x)}
    Instagram.media_search("41.924404","-87.654333",{radius: 4500, count: 11}).each {|x| instagrams.push(x)}
    counter=0
    instagrams.shuffle.each do |ig|
      counter += 1
      object = {latitude: ig.to_hash['location']['latitude'],longitude: ig.to_hash['location']['longitude'],url: "<a href=#{ig.to_hash['images']['low_resolution']['url']} target='new'><img src=#{ig.to_hash['images']['low_resolution']['url']} width=100 height=100></a>", }
      string = object.to_s
      # time =  Time.now.strftime("%3N")[1..2]
      $redis.hmset("object", counter.to_s, object)
    end
    sleep(75)
    p "fifth"
    instagrams = []
    Instagram.media_search("41.892594","-87.670984",{radius: 4500, count: 11}).each {|x| instagrams.push(x)}
    Instagram.media_search("41.866968","-87.654676",{radius: 4500, count: 11}).each {|x| instagrams.push(x)}
    Instagram.media_search("41.905499","-87.630558",{radius: 4500, count: 11}).each {|x| instagrams.push(x)}
    Instagram.media_search("41.930599","-87.665577",{radius: 4500, count: 11}).each {|x| instagrams.push(x)}

    counter=0
    instagrams.shuffle.each do |ig|
      counter += 1
      object = {latitude: ig.to_hash['location']['latitude'],longitude: ig.to_hash['location']['longitude'],url: "<a href=#{ig.to_hash['images']['low_resolution']['url']} target='new'><img src=#{ig.to_hash['images']['low_resolution']['url']} width=100 height=100></a>", }
      string = object.to_s
      # time =  Time.now.strftime("%3N")[1..2]
      $redis.hmset("object", counter.to_s, object)
    end
    sleep(10)
    finish =Time.now - duration
    p finish
    p "done"
  end

  def self.bikes
    bikes_request = open("http://divvybikes.com/stations/json").read()
    bikes_hash = JSON.parse(bikes_request)
    $redis.hmset("bikes", "bike_times",bikes_hash)
    p "+++++++++++++++++++ BIKES:    this is a new request    +++++++++++++++++++++++++"
    p Time.now
    p "+++++++++++++++++++ BIKES:    this is a new request    +++++++++++++++++++++++++"
        # send_message :success, train[:ctatt], namespace: :events
  end

  def self.eventful
    p "+++++++++++++++++     this is a new eventful request    ++++++++++++++++++++"
    p Time.now
    eventful = Eventful::API.new 'FwPV5FkjRBWzvzvq',
                                :user => ENV['USER_NAME'],
                                :password => ENV['PASSWORD']
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
    puts total_queries
    Event.destroy_all
    total_queries.times do |query|
      p query + 1
      begin
        results = eventful.call 'events/search',
          :location    => '41.8819, -87.6278',
          :within      => 6,
          :date        => Date.today,
          :sort_order  => 'popularity',
          :page_size   => 100,
          :page_number => query + 1
        results['events']['event'].each { |event|
          Event.create( title:         event['title'],
                        venue_name:    event['venue_name'],
                        latitude:      event['latitude'],
                        longitude:     event['longitude'],
                        start_time:    Time.new(event['start_time'].year,event['start_time'].month,event['start_time'].day,event['start_time'].hour,event['start_time'].min,event['start_time'].sec, '-06:00'),
                        at_time:       Time.new(event['start_time'].year,event['start_time'].month,event['start_time'].day,event['start_time'].hour,event['start_time'].min,event['start_time'].sec, '-06:00').strftime('%l:%M%P'),
                        stop_time:     event['stop_time'],
                        eventful_id:   event['id'],
                        thumb:         event['thumb'],
                        url:           event['url'],
                        city_name:     event['city_name'],
                        venue_address: event['venue_address'],
                        region_abbr:   event['region_abbr'],
                        postal_code:   event['postal_code'] )
        }
        puts Event.count
        sleep(180)
      rescue
        puts "false results from eventful"
        sleep(180)
      end
      p "+++++++++++++++++++  this is the end of an eventful request  +++++++++++++++++++"
    end
  end

  def self.eventbrite
    p "++++++++++++++++++++  this is a new Eventbrite request  +++++++++++++++++++++++++"
    p Time.now

    eb_auth_tokens = { app_key: ENV['EVENTBRITE'] }
    eb_client = EventbriteClient.new(eb_auth_tokens)
    eb_daily_total = eb_client.event_search( { date:       'Today',
                                               city:       'Chicago',
                                               count_only: true }
    )

    if ( eb_daily_total['events'][0]['summary']['total_items'] ) % 100 > 0
      pages = ( eb_daily_total['events'][0]['summary']['total_items'] / 100 ) + 1
    else
      pages = eb_daily_total['events'][0]['summary']['total_items'] / 100
    end

    Eventbrite.destroy_all
    pages.times { |page|
      eb_events = eb_client.event_search( { date:   'Today',
                                            city:   'Chicago',
                                            region: 'IL',
                                            max:    100,
                                            page:   page + 1 } )
      eb_events['events'].each_with_index { |eventbrite,index|
        if index == 0
          next
        else
          date = eventbrite['event']['start_date'].match(/(\d{4})-(\d{2})-(\d{2})\s(\d{2}):(\d{2}):(\d{2})/)
          end_date = eventbrite['event']['end_date'].match(/(\d{4})-(\d{2})-(\d{2})\s(\d{2}):(\d{2}):(\d{2})/)
          Eventbrite.create( title:         eventbrite['event']['title'],
                             venue:         eventbrite['event']['venue']['name'],
                             latitude:      eventbrite['event']['venue']['latitude'],
                             longitude:     eventbrite['event']['venue']['longitude'],
                             start_date:    Time.new(date.captures[0],date.captures[1],date.captures[2],date.captures[3],date.captures[4],date.captures[5],'-06:00'),
                             at_time:       Time.new(date.captures[0],date.captures[1],date.captures[2],date.captures[3],date.captures[4],date.captures[5],'-06:00').strftime('%l:%M%P'),
                             end_date:      Time.new(end_date.captures[0],end_date.captures[1],end_date.captures[2],end_date.captures[3],end_date.captures[4],end_date.captures[5],'-06:00'),
                             eventbrite_id: eventbrite['event']['id'],
                             thumb:         eventbrite['event']['logo_ssl'],
                             url:           eventbrite['event']['url'],
                             city:          eventbrite['event']['venue']['city'],
                             address:       eventbrite['event']['venue']['address'],
                             state:         eventbrite['event']['venue']['region'],
                             postal_code:   eventbrite['event']['venue']['postal_code'] )
        end
      }
      puts Eventbrite.count
    }
    p "++++++++++++++++++++  this is the end of an Eventbrite request  +++++++++++++++++++++"
  end

end
