@eventful = Eventful::API.new 'FwPV5FkjRBWzvzvq',
                                :user => 'josephjames890',
                                :password => 'veveve122'

def total_items
  first_query = @eventful.call 'events/search',
    :location  => 'Chicago',
    :date      => Date.today,
    :page_size => 1
  @total_items = first_query['total_items']
end

def number_of_queries
  total_queries = total_items / 100
  if @total_items % 100 > 0
    total_queries += 1
  end
  total_queries
end

def daily_queries
  @events = []
  queries = number_of_queries
  queries.times { |page|
    results = @eventful.call 'events/search',
      :location    => 'Chicago',
      :date        => Date.today,
      :sort_order  => 'popularity',
      :page_size   => 100,
      :page_number => page + 1

    results['events']['event'].each { |event|
      @events << { title: event['title'],
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

daily_queries