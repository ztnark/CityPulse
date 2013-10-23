# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Chicageaux::Application.load_tasks


begin
  gem 'tweetstream'
  require 'tweetstream'
end

namespace :jobs do
  desc "Heroku worker"
  task :work do
    exec('ruby twitter.rb run')
  end
end
