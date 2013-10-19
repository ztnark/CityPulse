
class HomeController < ApplicationController
  def index


  end

  def total_events_today
    first_query = @eventful.call 'events/search',
      :location    => '41.8819, -87.6278',
      :within      => 5,
      :date       => Date.today,
      :count_only => true
    @total_events = first_query['total_items']
  end

  def number_of_queries?
    @total_queries = @total_events / 100
    if @total_events % 100 > 0
      @total_queries += 1
    end
    @total_queries
  end

  def daily_queries(queries)
    @today_events = []
    queries.times { |page|
      if page > 9 && page % 10 == 0
        sleep(15)
      end
      results = @eventful.call 'events/search',
        :location    => '41.8819, -87.6278',
        :within      => 5,
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
      # sleep(20)
    }
    @today_events
  end

  def current_events
    @current_events = []
    Event.all.each { |event| @current_events << event }
    # Event.all.each { |event| @today_events << event }
    # @current_events.delete_if { |event| Time.at(event.stop_time) && Time.now - Time.at(event.stop_time) > 0 }
    # @current_events.delete_if { |event| Time.now - Time.at(event.start_time) > 10800 }
    # Event.all.each { |event|
    #   if Time.at(event.start_time) > Time.now && Time.at(event.start_time) - Time.now < 7200
    #     @current_events << event
    #   end
    # }
  end

  def eventful_fetcher
    @eventful = Eventful::API.new 'FwPV5FkjRBWzvzvq',
      :user => 'josephjames890',
      :password => 'veveve122'
    total_events_today
    number_of_queries?
    puts @total_events
    # daily_queries(@total_queries)
    # current_events
    # puts @current_events.length
    render :json => @current_events
  end


  def instagram_fetcher
    Instagram.configure do |config|
      config.client_id = "c20b0e71c0ae4c9092810007096d9217"
    end

   instagrams =Instagram.media_search("41.8929153","-87.6359125")
   @instagrams = []
   instagrams.each do |ig|
     @instagrams << {latitude: ig.to_hash['location']['latitude'],
                   longitude: ig.to_hash['location']['longitude'],
                   url: ig.to_hash['images']['low_resolution']['url'],
                   # text: ig.to_hash['caption']['text']
                 }
   end

  render :json => @instagrams


  end


end
