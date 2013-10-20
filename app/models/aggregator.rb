class Aggregator


@events = []

def self.eventful
eventful = Eventful::API.new 'FwPV5FkjRBWzvzvq',
                                :user => 'josephjames890',
                                :password => 'veveve122'
  first_query = eventful.call 'events/search',
    :location  => 'Chicago',
    :date      => Date.today,
    :page_size => 1
  @total_events = first_query
end

def self.trains
trains_api = "345d187dc00d467f9f2d1307b6e4b6c3"
  line = ['red','g','blue','brn','pink','org','p','y']
  trains = open("http://lapi.transitchicago.com/api/1.0/ttpositions.aspx?key=#{trains_api}&rt=#{line[0]}&rt=#{line[1]}&rt=#{line[2]}&rt=#{line[3]}&rt=#{line[4]}&rt=#{line[5]}&rt=#{line[6]}&rt=#{line[7]}").first
      puts "Here we go"
      puts "Here we are"
  @trains = CobraVsMongoose.xml_to_hash(trains)
  p @trains
end

def self.instagram
  Instagram.configure do |config|
      config.client_id = "c20b0e71c0ae4c9092810007096d9217"
    end
      request_for_instagrams =Instagram.media_search("41.915336","-87.681413",{radius: 4500})

      instagrams = []
      Instagram.media_search("41.909012","-87.634206",{radius: 4500}).each {|x| instagrams.push(x)}
      Instagram.media_search("41.878107","-87.627490",{radius: 4500}).each {|x| instagrams.push(x)}
      Instagram.media_search("41.882498","-87.668624",{radius: 4500}).each {|x| instagrams.push(x)}
      Instagram.media_search("41.925043","-87.652574",{radius: 4500}).each {|x| instagrams.push(x)}

      request_for_instagrams.shuffle.each do |ig|
        instagrams << {latitude: ig.to_hash['location']['latitude'],
                        longitude: ig.to_hash['location']['longitude'],
                        url: "<a href=#{ig.to_hash['images']['low_resolution']['url']} target='new'><img src=#{ig.to_hash['images']['low_resolution']['url']} width=100 height=100></a>",
                        # text: ig.caption.text
                       }
      p instagrams
    end
end

p Aggregator.trains

# def number_of_queries?
#   @total_queries = total_events_today / 100
#   if @total_events % 100 > 0
#     @total_queries += 1
#   end
#   @total_queries
# end

# def daily_queries(queries)
#   queries.times { |page|
#     results = @eventful.call 'events/search',
#       :location    => 'Chicago',
#       :date        => Date.today,
#       :sort_order  => 'popularity',
#       :page_size   => 100,
#       :page_number => page + 1

#     results['events']['event'].each { |event|
#       @events << { title:       event['title'],
#                    venue_name:  event['venue_name'],
#                    latitude:    event['latitude'],
#                    longitude:   event['longitude'],
#                    start_time:  event['start_time'],
#                    stop_time:   event['stop_time'],
#                    eventful_id: event['id'] }
#     }
#   }
#   @events
# end

# number_of_queries?

# while @total_queries > 4
#   @total_queries -= 4
#   daily_queries(4)
#   puts @events.length
#   sleep(5)
# end

# daily_queries(@total_queries) 
  
# end
end
