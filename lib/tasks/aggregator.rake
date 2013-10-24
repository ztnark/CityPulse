
namespace :aggregator do
  desc "run trains"
  task :trains => :environment do
    Aggregator.trains
  end

  desc "run instagram"
  task :instagram => :environment do
    Aggregator.instagram
  end

  desc "run divvy"
  task :bikes => :environment do
    Aggregator.bikes
  end

  desc "run divvy"
  task :planes => :environment do
    Aggregator.planes
  end

  desc "run divvy"
  task :events => :environment do
    Aggregator.eventful
  end
end
