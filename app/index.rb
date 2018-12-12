require "bundler/setup"

require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'google/apis/calendar_v3'
require 'json'
require 'pry'
require 'optparse'

load Pathname.pwd.to_s + '/app/authorization.rb'

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
    p auth.authorization_url
  when 'store_token'
    auth.store_token(arguments[1])
  when 'list'
  when 'insert'
  when 'update'
  when 'help'
  else
    p 'Command not found\n'
end
