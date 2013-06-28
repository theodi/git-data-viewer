require 'spec_helper'

describe Repository do

  before :all do
    @r = Repository.new(uri: "http://github.com/theodi/github-viewer-test-data.git")
  end

  # it "can generate a stripped version of the uri for descriptions and links" do
  #   @r.stripped_uri.should == 'github.com/theodi/github-viewer-test-data'
  # end

  context 'with data on github' do

    it 'correctly identified https URLs' do
      r = Repository.new(uri: "http://github.com/theodi/github-viewer-test-data.git")
      r.host.should == :github
    end
    
    it 'correctly identified http URLs' do
      r = Repository.new(uri: "http://github.com/theodi/github-viewer-test-data.git")
      r.host.should == :github
    end
    
    it 'correctly identified git URLs' do
      r = Repository.new(uri: "http://github.com/theodi/github-viewer-test-data.git")
      r.host.should == :github
    end

  end
  
end