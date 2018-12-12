require "bundler/setup"

require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'google/apis/calendar_v3'
require 'json'
require 'pry'
require 'optparse'
require 'date'
require_relative './authorization'
require_relative './google_calendar_client'

auth = Authorization.new

arguments = []
OptionParser.new do |o|
  begin
    arguments = o.parse(ARGV)
  rescue OptionParser::InvalidOption => e
    puts e
    exit 1
  end
end

case arguments[0]
  when 'url'
    puts auth.authorization_url
  when 'store_token'
    auth.store_credential(arguments[1])
    puts "done!!\n"
  when 'events_today'
    client = GoogleCalendarClient.new(auth.get_credential)
    client.events_today
  when 'insert_event'
    client = GoogleCalendarClient.new(auth.get_credential)

    now = DateTime.now
    time_min = DateTime.new(now.year, now.month, now.mday, now.hour, now.minute, 0, "+0900")
    time_max = time_min + 10r/24/60/60

    time_start = Google::Apis::CalendarV3::EventDateTime.new(date_time: time_min.rfc3339)
    time_end = Google::Apis::CalendarV3::EventDateTime.new(date_time: time_max.rfc3339)
    summary = 'テストです'
    params = {
      start: time_start,
      end: time_end,
      summary: summary,
    }

    client.insert_event(params)
  when 'help'
  else
    puts "Command not found\n"
end
