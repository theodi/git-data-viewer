require 'data_kitten/hosts/github'

module DataKitten
  
  module Hosts

    private

    def detect_host
      [
        DataKitten::Hosts::Github
      ].each do |host|
        extend host if host.supported?(@access_url)
      end
    end

  end
  
end