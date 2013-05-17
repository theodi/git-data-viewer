require 'csv'
require 'uri'
require 'cgi'
require 'git'

require 'data_kitten/license'
require 'data_kitten/agent'
require 'data_kitten/dataset'
require 'data_kitten/distribution'

# A collection of classes that represent Datasets and other concepts, modeled on {http://www.w3.org/TR/vocab-dcat/ DCAT}.
#
# The module is designed to automatically interrogate data sources and give back data and metadata in a consistent
# format. The best starting place is probably by having a look at {Dataset}.
#
# It is designed to handle data from multiple {Sources} (such as git repositories, local files, remote URLs), 
# {Hosts} (GitHub, etc), and {PublishingFormats} (DataPackage, RDFa, microdata, DSPL, etc).
#
# Currently supports Datapackages in git repositories (including but not limited to GitHub repos). Wider support will follow.
#
module DataKitten
end