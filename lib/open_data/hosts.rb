require 'open_data/hosts/github'

module OpenData
  
  module Hosts

    private

    def detect_host
      [
        OpenData::Hosts::Github
      ].each do |host|
        extend host if host.supported?(@uri)
      end
    end

  end
  
end