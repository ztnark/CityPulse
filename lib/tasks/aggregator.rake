
namespace :aggregator do
  desc "run trains"
  task :trains => :environment do
    Aggregator.trains
  end

  desc "run instagram"
  task :instagram => :environment do
    Aggregator.instagram
  end

  desc "run bikes"
  task :bikes => :environment do
    Aggregator.bikes
  end

  desc "run planes"
  task :planes => :environment do
    Aggregator.planes
  end

  desc "run events"
  task :events => :environment do
    Aggregator.eventful
  end

  desc "run eventbrite"
  task :events => :environment do
    Aggregator.eventbrite
  end
end
