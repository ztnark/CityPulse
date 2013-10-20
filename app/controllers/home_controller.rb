require 'redis'
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


  end



  # def total_events_today
  #   @first_query = @eventful.call 'events/search',
  #     :location  => 'Chicago',
  #     :date      => Date.today,
  #     :page_size => 1
  #   puts @first_query['total_items']
  #   @total_events = @first_query['total_items']
  # end

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
    @eventful = Eventful::API.new 'FwPV5FkjRBWzvzvq',
      :user => 'josephjames890',
      :password => 'veveve122'

    # @today_events = Event.all.each { |event| @today_events << event }
    # if @today_events.length < 1
    # total_events_today
    # number_of_queries?
    daily_queries(3)
    # end
    @current_events = []
    @today_events.each { |event| @current_events << event if (event.start_time - (Time.now - 18000)) < 900 && (event.start_time - (Time.now - 18000)) > -7200 }

    puts @today_events.length
    puts @current_events.length

    send_message :tweet_success, @current_events, namespace: :events
  end
end

