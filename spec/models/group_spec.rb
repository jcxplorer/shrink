require 'spec_helper'

describe Group do

  context "initialization" do
  
    it "accepts a document" do
      document = {
        "name" => "Backtrace",
        "display" => "text",
        "text" => "app.rb:54"
      }
      group = Group.new(document)

      group.name.should == "Backtrace"
      group.display.should == "text"
      group.text.should == "app.rb:54"
    end

  end

  context "attributes" do

    it "returns an array if the document contains them" do
      group = Group.new({ "attributes" => [{}, {}] })
      group.attributes.count.should == 2
    end

    it "returns an empty array if the document doesn't have any" do
      group = Group.new
      group.attributes.should == []
    end

  end

  context "display" do

    it "is 'list' by default" do
      group = Group.new
      group.display.should == "list"

      group = Group.new({ "display" => "text" })
      group.display.should == "text"
    end

  end

end
