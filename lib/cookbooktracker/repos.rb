module CookbookTracker
  module Repos
    def self.registered(app)

      app.get '/repos' do

        octokit_client = Octokit::Client.new(:login => github_user.login, :oauth_token => github_user.token)
        octokit_client.auto_paginate = true
        @repos = octokit_client.org_repos('opscode-cookbooks', {:type => 'public'})
        @repos.sort_by! { |repo| repo[:open_issues_count] }.reverse!
        erb :repos
      end

    end
  end
end
