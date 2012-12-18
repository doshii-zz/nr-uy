class MyNewApp::Routes

  get named(:home, '/') do
    haml :'home'
  end

end
