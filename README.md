# google-calendar-api-sandbox

google-calendar-api-sandbox

## Requirement

1. clone this repository
2. get google calendar `client_id.json` and put it root of this repository 
    (if you have no project, you must create a project.)
3. `bundle install --path=vendor/bundle`

## How To Use

```shell
$ cd (path)/google-calendar-api-sandbox

$ ruby app/index.rb url
# You can get URL for OAuth2 
# Open this URL in your brouser and get authorization
# Then you can get the code

$ CODE=`$CODE`
$ ruby app/index.rb store_token CODE 
# `token_store` file will be created.

# list events of today
$ ruby app/index.rb events_today

# insert_event
$ ruby app/index.rb insert_event

```

## Refference

[Google::Client::CalendarV3::CalendarService](https://www.rubydoc.info/github/google/google-api-ruby-client/Google/Apis/CalendarV3/CalendarService)
