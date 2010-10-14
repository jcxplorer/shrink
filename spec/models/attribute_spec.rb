require 'spec_helper'

describe Attribute do

  context "initialization" do

    it "accepts a document" do
      attribute = Attribute.new({ "key" => "Path", "value" => "/info" })
      attribute.key.should == "Path"
      attribute.value.should == "/info"
    end

  end

end
