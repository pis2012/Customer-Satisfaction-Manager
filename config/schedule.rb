# Learn more: http://github.com/javan/whenever
require "./config/application.rb"
require "./app/models/csm_property.rb"

set :output, "/tmp/csm_cron.log"

def getTime
  CsmProperty.establish_connection(
      adapter: "mysql2",
      encoding: "utf8",
      reconnect: "false",
      database: "CSM_development",
      pool: "5",
      username: "csmdevuser",
      password: 'password',
      socket: "/var/run/mysqld/mysqld.sock"
  )
  property = CsmProperty.find_by_name("MinutesBetweenReminderEmails")
  timeInMinutes = 1440 # 1 day
  timeInMinutes = Integer(property.value) if property
end

every getTime().minutes do
   runner "MyProjectsHelper.send_reminder_email"
end

every 5.minutes do
  command "cd '" + Dir.pwd  + "' && whenever --update-crontab CSM"
end

