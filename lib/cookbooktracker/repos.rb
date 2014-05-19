module CookbookTracker
  module Repos
    def self.registered(app)

      app.get '/repos' do

        @repos = $github_user.org_repos('opscode-cookbooks', {:type => 'public'})
        erb :repos
      end

    end
  end
end
