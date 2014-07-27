module CookbookTracker
  module Cla
    def self.registered(app)

      app.get '/cla' do

        cla_label = 'Signed CLA'

        octokit_client = github_user.api

        octokit_client.auto_paginate = true
        repos = octokit_client.org_repos('opscode-cookbooks', {:type => 'public'})
        @cla = []
        repos.each do |r|
          if r.has_issues?
            issues = octokit_client.list_issues(r.full_name, {:labels => cla_label})
            @cla << {:repo => r.full_name, :count => issues.count}
          end
        end
        @cla.sort_by! { |r| r[:count] }.reverse!
        @title = "PRs with Signed CLAs"
        @github_login = github_user.login
        erb :cla
      end

    end
  end
end
