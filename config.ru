ENV['RACK_ENV'] ||= 'development'
require "rubygems"
require "bundler/setup"
require "sinatra_auth_github"

$LOAD_PATH << File.dirname(__FILE__) + '/lib'

require "cookbooktracker/app"

use Rack::Static, :urls => ["/css", "/img", "/js", "/font-awesome", "/fonts"], :root => "public"

run CookbookTracker::App
