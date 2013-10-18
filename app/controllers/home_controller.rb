
class HomeController < ApplicationController
  def index


  end

  def total_events_today
    @first_query = @eventful.call 'events/search',
      :location  => 'Chicago',
      :date      => Date.today,
      :page_size => 1
    puts @first_query['total_items']
    @total_events = @first_query['total_items']
  end

  def number_of_queries?
    @total_queries = total_events_today / 100
    if @total_events % 100 > 0
      @total_queries += 1
    end
    @total_queries
  end

  def daily_queries(query)
    # queries.times { |page|
    #   if (page + 1) % 3 == 1
    #     sleep(15)
    #   end
      results = @eventful.call 'events/search',
        :location    => 'Chicago',
        :date        => Date.today,
        :sort_order  => 'popularity',
        :page_size   => 100,
        :page_number => query

      results['events']['event'].each { |event|
        @events << { title:       event['title'],
                     venue_name:  event['venue_name'],
                     latitude:    event['latitude'],
                     longitude:   event['longitude'],
                     start_time:  event['start_time'],
                     stop_time:   event['stop_time'],
                     eventful_id: event['id'] }
      }
      puts @events.length
    # }
    @events
  end

  def eventful_fetcher
    @eventful = Eventful::API.new 'FwPV5FkjRBWzvzvq',
                                :user => 'josephjames890',
                                :password => 'veveve122'
    @events = []
    # number_of_queries?
    daily_queries(1)

    results['events']['event'].each do |event|
      @events << { title: event['title'],
                   venue_name: event['venue_name'],
                   latitude: event['latitude'],
                   longitude: event['longitude'],
                   start_time: event['start_time'],
                   stop_time: event['stop_time'],
                   eventful_id: event['id']
                 }
    end
    p @events
    render :json => @events
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
