module CookbookTracker
  module Cla
    def self.registered(app)

      app.get '/cla' do

        cla_label = 'Signed CLA'

        #octokit_client = Octokit::Client.new(:access_token => github_user.token)
        #octokit_client = Octokit::Client.new(:login => github_user.login, :access_token => github_user.access_token)

        github_user.api.auto_paginate = true
        repos = github_user.api..org_repos('opscode-cookbooks', {:type => 'public'})
        @cla = []
        repos.each do |r|
          if r.has_issues?
            issues = github_user.api.list_issues(r.full_name, {:labels => cla_label})
            @cla << {:repo => r.full_name, :count => issues.count}
          end
        end
        erb :cla
      end

    end
  end
end
