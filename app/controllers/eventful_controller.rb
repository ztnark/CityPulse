require 'event'

@eventful = Eventful::API.new 'FwPV5FkjRBWzvzvq',
                                :user => 'josephjames890',
                                :password => 'veveve122'

@events = []

def total_events_today
  first_query = @eventful.call 'events/search',
    :location  => 'Chicago',
    :date      => Date.today,
    :page_size => 1
  @total_events = first_query['total_items']
end

def number_of_queries?
  @total_queries = total_events_today / 100
  if @total_events % 100 > 0
    @total_queries += 1
  end
  @total_queries
end

def daily_queries(queries)
  queries.times { |page|
    results = @eventful.call 'events/search',
      :location    => 'Chicago',
      :date        => Date.today,
      :sort_order  => 'popularity',
      :page_size   => 100,
      :page_number => page + 1

    results['events']['event'].each { |event|
      @events << { title:       event['title'],
                   venue_name:  event['venue_name'],
                   latitude:    event['latitude'],
                   longitude:   event['longitude'],
                   start_time:  event['start_time'],
                   stop_time:   event['stop_time'],
                   eventful_id: event['id'] }
    }
  }
  @events
end

def do_stuff
  number_of_queries?

  while @total_queries > 4
    @total_queries -= 4
    daily_queries(4)
    puts @events.length
    sleep(5)
  end

  daily_queries(@total_queries)

  p total_events_today
end

