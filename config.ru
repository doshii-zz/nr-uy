require File.dirname(__FILE__) + '/boot/boot.rb'

use Rack::Cache, verbose: false

map MyNewApp::Routes.assets_prefix do
  run MyNewApp::Routes.assets
end

run MyNewApp::Routes
