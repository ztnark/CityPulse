
namespace :aggregator do
  desc "sced job"
  task :trains => :environment do
    Aggregator.instagram
  end
end
