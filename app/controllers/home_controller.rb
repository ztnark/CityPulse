
class HomeController < ApplicationController
  def index


  end

  def eventful_fetcher
    eventful = Eventful::API.new 'FwPV5FkjRBWzvzvq',
                                :user => 'josephjames890',
                                :password => 'veveve122'

    results = eventful.call 'events/search',
                           :location => 'Chicago',
                           :date => Date.today,
                           :sort_order => 'popularity',
                           :page_size => 100

    @events = []
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
