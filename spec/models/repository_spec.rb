require 'spec_helper'

describe Repository do

  before :all do
    @r = Repository.new(uri: "http://example.com/org/repo.git")
  end

  it "can generate a stripped version of the uri for descriptions and links" do
    @r.stripped_uri.should == 'example.com/org/repo'
  end
  
  context 'with data on github' do

    it 'correctly identified https URLs' do
      r = Repository.new(uri: "https://github.com/org/repo.git")
      r.should be_hosted_by_github
    end
    
    it 'correctly identified http URLs' do
      r = Repository.new(uri: "http://github.com/org/repo.git")
      r.should be_hosted_by_github
    end
    
    it 'correctly identified git URLs' do
      r = Repository.new(uri: "git://github.com/org/repo.git")
      r.should be_hosted_by_github
    end

  end
  
end