# Github Viewer

An experiment in displaying Open Data stored in Github in a nice way for non-developers.

Relies on a variant of Andrew Berkeley's [calcJSON](https://github.com/spatchcock/calcJSON) format to load metadata from repository.

For more details, see the [sample repository](https://github.com/theodi/github-viewer-test-data).

Requirements
------------

This uses Ruby 2 and Rails 4 beta 1. Caveat Emptor.

License
-------

This code is open source under the MIT license. See the LICENSE.md file for 
full details.

Environment
-----------

The following environment variables should be set in a .env file in order to use this app.

    GITHUB_OAUTH_TOKEN='your-oauth-token-for-your-app'
    
See [peter-murach/github](https://github.com/peter-murach/github) for details on how to set this up.