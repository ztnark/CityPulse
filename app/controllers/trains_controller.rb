class TrainsController < ApplicationController

  require 'open-uri'

  def index
  end

  def train_fetcher
    puts "we are in the train fetcher"
    api_key = "345d187dc00d467f9f2d1307b6e4b6c3"
    line = ['red','g','blue','brn','pink','org','p','y']
    @trains = [open("http://lapi.transitchicago.com/api/1.0/ttpositions.aspx?key=#{api_key}&rt=#{line[0]}&rt=#{line[1]}&rt=#{line[2]}&rt=#{line[3]}&rt=#{line[4]}&rt=#{line[5]}&rt=#{line[6]}&rt=#{line[7]}").first]
    render :json => @trains
  end

end
