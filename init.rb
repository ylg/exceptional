require 'exceptional'

# If old plugin still installed then we don't want to install this one.
# In production environments we should continue to work as before, but in development/test we should
# advise how to correct the problem and exit
if defined?(Exceptional::VERSION::STRING) && %w(development test).include?(RAILS_ENV)
  message = %Q(
  ***********************************************************************
  You seem to still have an old version of the exceptional plugin installed.
  Remove it from /vendor/plugins and try again.
  ***********************************************************************
  )
  puts message
  exit -1
else
  begin
    config_file = "#{RAILS_ROOT}/config/exceptional.yml"
    Exceptional::Config.load(RAILS_ROOT, RAILS_ENV, config_file)
    Exceptional::Startup.announce
    require File.join('exceptional', 'integration', 'rails')
  rescue => e
    STDERR.puts "Problem starting Exceptional Plugin. Your app will run as normal."
    STDERR.puts e
  end
end