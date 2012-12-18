Basic sinatra setup
===========

Basic sinatra setup, prepared to be hosted in a Heroku environment.

Gemfile
-------
```
    ruby '2.0.0'

    rack-cache
    sinatra
    sinatra-namespace
    sinatra-named_routes

    haml
    sass

    thin
    compass
    sprockets
    sprockets-helpers
    sprockets-sass
```

Run `rake rename_app:<NewName>' to change the app name
