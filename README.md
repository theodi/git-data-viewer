# Github Viewer

An experiment in displaying Open Data stored in Github in a nice way for non-developers.

Relies on a loading metadata from a [DataPackage](http://www.dataprotocols.org/en/latest/data-packages.html) file contained in the repository.

For more details, see the [sample repository](https://github.com/theodi/github-viewer-test-data).

Requirements
------------

This uses Ruby 2 and Rails 4 rc 1. Caveat Emptor.

License
-------

This code is open source under the MIT license. See the LICENSE.md file for 
full details.

Environment
-----------

The following environment variables should be set in a .env file in order to use this app.

    GITHUB_OAUTH_TOKEN='your-oauth-token-for-your-app'
    
To get this token, create an application in Github/settings/applications and follow these instructions in ```irb```:

    require 'github_api'
    github = Github.new :client_id => '...', :client_secret => '...'
    github.authorize_url :redirect_uri => '...', :scope => 'repo'

Visit the URL it gives you. When you authorize it, it will send you to your redirect_uri with a token in the query string. Use this below:

    token = github.get_token('<token from query string>')
    puts token.token

This is the OAuth token you need in your environment.