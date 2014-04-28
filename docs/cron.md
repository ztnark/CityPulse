# schedule.rb erroring out

+ all output from cron jobs is logged in .logs/cron.log.
+ the stack can be traced back to config/boot.rb:4 `require 'bundler/setup'`
+ `ENV['PATH']` is `"/Users/henry/.rbenv/versions/2.1.0/lib/ruby/gems/2.1.0/bin:/Users/henry/.rbenv/versions/2.1.0/bin:/usr/local/Cellar/rbenv/0.4.0/libexec:/Applications/Postgres93.app/Contents/MacOS/bin:/Users/henry/.rbenv/shims:./bin:/usr/local/bin:/usr/local/sbin:/Users/henry/.sfs:/Users/henry/.dotfiles/bin:/usr/bin:/bin:/usr/sbin:/sbin"`
+ basic stack trace for every command:
      /System/Library/Frameworks/Ruby.framework/Versions/2.0/usr/lib/ruby/2.0.0/rubygems/core_ext/kernel_require.rb:45:in `require': cannot load such file -- bundler/setup (LoadError)
	   from /System/Library/Frameworks/Ruby.framework/Versions/2.0/usr/lib/ruby/2.0.0/rubygems/core_ext/kernel_require.rb:45:in `require'
	   from /Users/henry/Sites/personal/CityPulse/config/boot.rb:4:in `<top (required)>'
	   from bin/rails:3:in `require_relative'
	   from bin/rails:3:in `<main>'

My guess is it is related to Whenever not using or setting the right $PATH.
So I tried setting it in the schedule.rb file as both the path I have set in `ENV['PATH']`
and a path suggested in the issues section on the whenever gem. this path:
    `env :PATH, '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin'`
both are persistently resulting in the same stack trace.

I have now set the environment as development in the schedule.rb

part of the problem may be that cronjobs are not run in a login shell
This means that normal $HOME startup scripts are not executed.

the proper cron tab should look something like this:
    `* * * * * /bin/bash -l -c 'cd /Users/henry/Sites/personal/CityPulse && bin/rails runner -e development '\''Aggregator.trains'\'' >> log/cron.log 2>&1'`

problem solved!
