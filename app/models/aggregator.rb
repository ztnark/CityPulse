class Aggregator

def self.trains
  4.times do
  trains_api = "345d187dc00d467f9f2d1307b6e4b6c3"
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
        config.client_id = "c20b0e71c0ae4c9092810007096d9217"
      end
      instagrams =Instagram.media_search("41.915336","-87.681413",{radius: 4500})
      @instagrams = []
      Instagram.media_search("41.909012","-87.634206",{radius: 4500}).each {|x| instagrams.push(x)}
      Instagram.media_search("41.878107","-87.627490",{radius: 4500}).each {|x| instagrams.push(x)}
      Instagram.media_search("41.882498","-87.668624",{radius: 4500}).each {|x| instagrams.push(x)}
      Instagram.media_search("41.925043","-87.652574",{radius: 4500}).each {|x| instagrams.push(x)}
        counter=0
      instagrams.shuffle.each do |ig|
        # p counter += 1
        object = {latitude: ig.to_hash['location']['latitude'],longitude: ig.to_hash['location']['longitude'],url: "<a href=#{ig.to_hash['images']['low_resolution']['url']} target='new'><img src=#{ig.to_hash['images']['low_resolution']['url']} width=100 height=100></a>", }
        string = object.to_s
        time =  Time.now.strftime("%3N")[1..2]
        $redis.hmset("object" ,time ,object)
      end
      p "+++++++++++++++++    this is a new request    +++++++++++++++++++++++"
      p Time.now
      p "+++++++++++++++++    this is a new request    +++++++++++++++++++++++"
    end
end

