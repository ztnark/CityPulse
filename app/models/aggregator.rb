class Aggregator


  def self.trains
    4.times do
    trains_api = ENV['TRAINS_KEY']
    line = ['red','g','blue','brn','pink','org','p','y']
    trains_request = open("http://lapi.transitchicago.com/api/1.0/ttpositions.aspx?key=#{trains_api}&rt=#{line[0]}&rt=#{line[1]}&rt=#{line[2]}&rt=#{line[3]}&rt=#{line[4]}&rt=#{line[5]}&rt=#{line[6]}&rt=#{line[7]}").first
    trains_hash = CobraVsMongoose.xml_to_hash(trains_request)
    $redis.hmset("trains", "train_times", trains_hash)
    p "+++++++++++++++++++ TRAINS:    this is a new request    +++++++++++++++++++++++++"
    p Time.now
    p "+++++++++++++++++++ TRAINS:    this is a new request    +++++++++++++++++++++++++"
        # send_message :success, train[:ctatt], namespace: :events
    sleep(15)
   end
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

def self.instagram
  Instagram.configure do |config|
    config.client_id = ENV['INSTAGRAM']
  end
  instagrams = []
  Instagram.media_search("41.915336","-87.681413",{radius: 4500, count: 4}).each {|x| instagrams.push(x)}
  Instagram.media_search("41.958708","-87.655792",{radius: 4500, count: 4}).each {|x| instagrams.push(x)}
  Instagram.media_search("41.909012","-87.634206",{radius: 4500, count: 4}).each {|x| instagrams.push(x)}
  Instagram.media_search("41.878107","-87.627490",{radius: 4500, count: 4}).each {|x| instagrams.push(x)}
  Instagram.media_search("41.882498","-87.668624",{radius: 4500, count: 4}).each {|x| instagrams.push(x)}
  Instagram.media_search("41.925043","-87.652574",{radius: 4500, count: 2}).each {|x| instagrams.push(x)}
  Instagram.media_search("41.819344","-87.606354",{radius: 4500, count: 4}).each {|x| instagrams.push(x)}
  Instagram.media_search("41.816477","-87.687378",{radius: 4500, count: 4}).each {|x| instagrams.push(x)}
  Instagram.media_search("41.858011","-87.679825",{radius: 4500, count: 4}).each {|x| instagrams.push(x)}
  Instagram.media_search("41.860985","-87.624807",{radius: 4500, count: 4}).each {|x| instagrams.push(x)}
  Instagram.media_search("41.830081","-87.646523",{radius: 4500, count: 4}).each {|x| instagrams.push(x)}
  Instagram.media_search("41.899115","-87.715187",{radius: 4500, count: 4}).each {|x| instagrams.push(x)}
    counter=0
  instagrams.shuffle.each do |ig|
    counter += 1
    object = {latitude: ig.to_hash['location']['latitude'],longitude: ig.to_hash['location']['longitude'],url: "<a href=#{ig.to_hash['images']['low_resolution']['url']} target='new'><img src=#{ig.to_hash['images']['low_resolution']['url']} width=100 height=100></a>", }
    string = object.to_s
    # time =  Time.now.strftime("%3N")[1..2]
    $redis.hmset("object", counter.to_s, object)

  def self.planes
    4.times do
      planes_request = open("https://api.flightstats.com/flex/flightstatus/rest/v2/xml/airport/tracks/ORD/arr?appId=1962933e&appKey=a64909be7ac34351f562edd1acec0fba&includeFlightPlan=false&maxPositions=2&maxFlights=5").read()
      planes_hash = CobraVsMongoose.xml_to_hash(planes_request)
      $redis.hmset("planes", "plane_times", planes_hash)
      planes_request2 = open("https://api.flightstats.com/flex/flightstatus/rest/v2/xml/airport/tracks/MDW/arr?appId=1962933e&appKey=a64909be7ac34351f562edd1acec0fba&includeFlightPlan=false&maxPositions=2&maxFlights=5").read()
      planes_hash2 = CobraVsMongoose.xml_to_hash(planes_request2)
      $redis.hmset("planes2", "plane_times2", planes_hash2)
      p "+++++++++++++++++++ PLANES:    this is a new request    +++++++++++++++++++++++++"
      p Time.now
      p "+++++++++++++++++++ PLANES:    this is a new request    +++++++++++++++++++++++++"
          # send_message :success, train[:ctatt], namespace: :events
      # sleep(15)
    end
  end


  def self.bikes
    bikes_request = open("http://divvybikes.com/stations/json").read()
    bikes_hash = JSON.parse(bikes_request)
    $redis.hmset("bikes", "bike_times",bikes_hash)
    p "+++++++++++++++++++ BIKES:    this is a new request    +++++++++++++++++++++++++"
    p Time.now
    p "+++++++++++++++++++ BIKES:    this is a new request    +++++++++++++++++++++++++"
        # send_message :success, train[:ctatt], namespace: :events

  def self.instagram
    Instagram.configure do |config|
      config.client_id = ENV['INSTAGRAM']
    end
    instagrams =Instagram.media_search("41.915336","-87.681413",{radius: 4500})
    @instagrams = []
    Instagram.media_search("41.909012","-87.634206",{radius: 4500}).each {|x| instagrams.push(x)}
    Instagram.media_search("41.878107","-87.627490",{radius: 4500}).each {|x| instagrams.push(x)}
    Instagram.media_search("41.882498","-87.668624",{radius: 4500}).each {|x| instagrams.push(x)}
    Instagram.media_search("41.925043","-87.652574",{radius: 4500}).each {|x| instagrams.push(x)}
      counter=0
    instagrams.shuffle.each do |ig|
      counter += 1
      object = {latitude: ig.to_hash['location']['latitude'],longitude: ig.to_hash['location']['longitude'],url: "<a href=#{ig.to_hash['images']['low_resolution']['url']} target='new'><img src=#{ig.to_hash['images']['low_resolution']['url']} width=100 height=100></a>", }
      string = object.to_s
      # time =  Time.now.strftime("%3N")[1..2]
      $redis.hmset("object", counter.to_s, object)
    end
    p "+++++++++++++++++    this is a new request    +++++++++++++++++++++++"
    p Time.now
    p "+++++++++++++++++    this is a new request    +++++++++++++++++++++++"
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
    puts total_queries

    Event.destroy_all
    total_queries.times do |query|
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
                      start_time:    Time.new(event['start_time'].year,event['start_time'].month,event['start_time'].day,event['start_time'].hour,event['start_time'].min,event['start_time'].sec, '-05:00'),
                      at_time:       Time.new(event['start_time'].year,event['start_time'].month,event['start_time'].day,event['start_time'].hour,event['start_time'].min,event['start_time'].sec, '-05:00').strftime('%l:%M%P'),
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
      sleep(120)
    end
    p "+++++++++++++++++++     this is a new eventful request    +++++++++++++++++++++++++"
  end

end

