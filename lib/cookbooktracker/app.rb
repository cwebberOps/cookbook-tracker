module CookbookTracker
  class App < Sinatra::Base

    set :views, settings.root + '/views'
    require 'cookbooktracker/repos'


    register CookbookTracker::Repos

    require 'octokit'
    $github_user = Octokit::Client.new(:access_token => ENV['GITHUB_API_KEY'])
    $github_user.auto_paginate = true

    enable :sessions

    #set :github_options, {
    #  :scopes => 'user',
    #  :secret => ENV['GITHUB_CLIENT_SECRET'],
    #  :client_id => ENV['GITHUB_CLIENT_ID'],
    #}

    GITHUB_TEAM_ID = ENV['GITHUB_TEAM_ID']
    GITHUB_ORG = ENV['GITHUB_ORG']

#    register Sinatra::Auth::Github

#    before do
#      github_organization_authenticate!(GITHUB_ORG)
#    end


    get '/' do
      "Hello there, #{github_user.login}!"
    end

    get '/logout' do
      logout!
      redirect 'https://github.com'
    end

  end

end
