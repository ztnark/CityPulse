require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'  

set :domain, '107.170.178.218' 
set :deploy_to, '/var/www/citypulse.io/'
set :repository, 'git@github.com:ztnark/CityPulse.git'
set :branch, ENV['branch'] || 'master'


set :user, 'root'    # Username in the server to SSH to.

task :environment do
  invoke :'rbenv:load'
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    invoke :'git:clone'
  end
end
