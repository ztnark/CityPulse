# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# sends all output to this file. check here if you are not sure how crons are running
set :output, 'log/cron.log'

every 10.minutes do
  runner "Aggregator.instagram", environment: 'development'
end


every 1.minutes do
  runner "Aggregator.trains", environment: 'development'
end

every 1.day, :at => '2:05 am' do
  runner "Aggregator.eventful", environment: 'development'
end

every 1.day, :at => '2:00 am' do
  runner "Aggregator.eventbrite", environment: 'development'
end

every 1.minutes do
  runner "Aggregator.planes", environment: 'development'
end

every 5.minutes do
  runner "Aggregator.bikes", environment: 'development'
end
