
WebsocketRails::EventMap.describe do
  # You can use this file to map incoming events to controller actions.
  # One event can be mapped to any number of controller actions. The
  # actions will be executed in the order they were subscribed.
  #
  # Uncomment and edit the next line to handle the client connected event:
  #   subscribe :client_connected, :to => Controller, :with_method => :method_name
  #
  # Here is an example of mapping namespaced events:
  #   namespace :product do
  #     subscribe :new, :to => ProductController, :with_method => :new_product
  #   end
  # The above will handle an event triggered on the client like `product.new`.



  namespace :events do
    subscribe :tweets, 'event#tweets'
    # subscribe :instagram, 'event#instagram_fetcher'
    # subscribe :instagram, 'event#instagram'
    subscribe :instagram_initialize, 'event#instagram_initialize'
    subscribe :trains, 'event#trains'
    subscribe :eventful, 'event#eventful_fetcher'
    subscribe :planes, 'event#planes'
    subscribe :bikes, 'event#bikes'
    subscribe :test, 'event#test'
  end
end
