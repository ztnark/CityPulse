class TrainsController < ApplicationController

  def index
  end

  def train_fetcher
    puts "we are in the train fetcher"
    api_key = "345d187dc00d467f9f2d1307b6e4b6c3"
    @trains = []
    lines = ['red','g','blue','brn','pink','org','p','y']
    lines.each { |line| @trains << open("http://lapi.transitchicago.com/api/1.0/ttpositions.aspx?key=#{api_key}&rt=#{line}").first }
    render :json => @trains
  end

end
