# Learn more: http://github.com/javan/whenever
require "./config/environment.rb"

set :output, "/tmp/csm_cron.log"

def getTime
  timeInMinutes = Integer(CsmProperty.get_property("MinutesBetweenReminderEmails","1440"))
  timeInMinutes
end

every getTime().minutes do
   runner "MyProjectsHelper.send_reminder_email"
end

every 5.minutes do
  command "cd '" + Dir.pwd  + "' && whenever --update-crontab CSM"
end

