module CookbookTracker
  module Repos
    def self.registered(app)

      app.get '/repos' do

        @repos = github_user.api.org_repos('opscode-cookbooks', {:type => 'public'})
        @repos.sort_by! { |repo| repo[:open_issues_count] }.reverse!
        erb :repos
      end

    end
  end
end
