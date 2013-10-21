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
  sleep(13)
 end
end

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

    

  @@query = 17



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
      puts Event.count
      sleep(120)
    end
    p "+++++++++++++++++++     this is a new eventful request    +++++++++++++++++++++++++"
  end

end

