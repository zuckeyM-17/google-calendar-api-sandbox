class GoogleCalendarClient

  def initialize(credentials)
    @service = Google::Apis::CalendarV3::CalendarService.new
    @service.authorization = credentials
  end

  def events_today
    now = DateTime.now
    time_min = DateTime.new(now.year, now.month, now.mday, 0, 0, 0, "+0900")
    time_max = time_min + 1
    params = {
        time_min: time_min.rfc3339,
        time_max: time_max.rfc3339,
        single_events: true,
    }
    list_events(params)
  end

  def list_events(params)
    events = @service.list_events('primary', params).items
    events.each do |e|
      puts "#{e.id}\t#{e.summary}\t#{e.transparency}\t#{e.location}\t#{e.start.date_time.strftime('%Y-%m-%d %H:%M')}\t#{e.end.date_time.strftime('%Y-%m-%d %H:%M')}"
    end
  end

  def insert_event(params)
    event = Google::Apis::CalendarV3::Event.new(params)
    puts @service.insert_event('primary', event)
  end
end
