require 'spec_helper'

describe Repository do

  before :all do
    @r = Repository.new(uri: "http://example.com/org/repo.git")
  end

  it "can generate a stripped version of the uri for descriptions and links" do
    @r.stripped_uri.should == 'example.com/org/repo'
  end
  
end