module CookbookTracker
  module Cla
    def self.registered(app)

      app.get '/cla' do

        cla_label = 'Signed CLA'

        octokit_client = Octokit::Client.new(:access_token => github_user.token)

        return octokit_client.user

        octokit_client.auto_paginate = true
        repos = octokit_client.org_repos('opscode-cookbooks', {:type => 'public'})
        @cla = []
        repos.each do |r|
          if r.has_issues?
            issues = octokit_client.list_issues(r.full_name, {:labels => cla_label})
            @cla << {:repo => r.full_name, :count => issues.count}
          end
        end
        erb :cla
      end

    end
  end
end
