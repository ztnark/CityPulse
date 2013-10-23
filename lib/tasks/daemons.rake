
namespace :jobs do
  desc "Heroku worker"
  task :work do
    exec('ruby twitter.rb start')
  end
end
