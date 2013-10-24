gem 'cobravsmongoose'
require 'open-uri'
require 'cobravsmongoose'

    40.times do
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
