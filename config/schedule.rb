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

every 2.minutes do
  runner "Aggregator.instagram"
end

every 1.minutes do
  runner "Aggregator.trains"
end
