require_relative "../env"
begin
  require_relative "../env.local"
rescue LoadError
end

require 'bundler'
Bundler.require(:default)

module MyNewApp
  module Helpers
  end

  class Routes < Sinatra::Application
    set :root, File.dirname(__FILE__) + "/../"
    set :views, File.join("app", "views")
    set :show_exceptions, true
    set :environment, ENV["RACK_ENV"]

    set :assets, Sprockets::Environment.new(root)
    set :precompile, [ /\w+\.(?!js|css).+/, /application.(css|js)$/ ]
    set :assets_prefix, '/assets'
    set :digest_assets, false
    set(:assets_path)   { File.join public_folder, assets_prefix }

    configure do
      # Setup Sprockets
      %w{scripts stylesheets images fonts}.each do |type|
        assets.append_path "app/assets/#{type}"
      end

      # Configure Sprockets::Helpers (if necessary)
      Sprockets::Helpers.configure do |config|
        config.environment = assets
        config.prefix      = assets_prefix
        config.digest      = digest_assets
        config.public_path = public_folder
      end

      set :haml, { format: :html5 }
    end

    register Sinatra::NamedRoutes
    register Sinatra::Namespace

    use Rack::Session::Cookie, key: "MyNewApp", secret: "p27msr0v1e0l9e3z"
    use Rack::MethodOverride

    helpers do
      include Sprockets::Helpers
      include Sinatra::NamedRoutes::Helpers
      include Helpers
    end
  end
end

# Sort to ensure same order in all environments
Dir["./app/models/**/*.rb"].sort.each  { |rb| require rb }
Dir["./app/routes/**/*.rb"].sort.each  { |rb| require rb }
Dir["./app/helpers/**/*.rb"].sort.each { |rb| require rb }
