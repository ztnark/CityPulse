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

# # Learn more: http://github.com/javan/whenever
# every 2.hours do
#   runner "Aggregator.eventful"
# end

every 2.minute do 
  runner "Aggregator.trains"
end

every 3.minute do
  runner "Aggregator.instagram"
end
