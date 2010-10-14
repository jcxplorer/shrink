require 'spec_helper'

describe Notification do

  before(:each) do
    @project_token = "924ed0aa73f519166f3e963f409f2f89"

    @incoming_hash = {
      "id" => "3e83a29e908ccef726743cd203da032b",
      "token" => @project_token,
      "title" => "NameError: uninitialized constant Notification"
    }
  end

  context "initialization" do

    it "accepts a document" do
      document = {
        "id" => "1",
        "title" => "NotImplementedError"
      }
      notification = Notification.new(document)

      notification.id.should == "1"
      notification.title.should == "NotImplementedError"
    end

  end
    
  context "saving" do

    it "is done to a collection named after the token" do
      cursor = Mongo.db[@project_token].find
      cursor.count.should == 0
      Notification.save(@incoming_hash)
      cursor.count.should == 1
    end
    
    it "creates a new document if the notification id doesn't exist" do
      Notification.save(@incoming_hash)
      expected_document = {
        "id" => "3e83a29e908ccef726743cd203da032b",
        "title" => "NameError: uninitialized constant Notification",
        "occurrences" => 1
      }

      cursor = Mongo.db[@project_token].find
      cursor.count.should == 1
      document = cursor.first
      document.delete("_id")
      document.should == expected_document
    end

    it "increments the occurrence counter if the notification id exists" do
      3.times { Notification.save(@incoming_hash) }
      cursor = Mongo.db[@project_token].find
      cursor.count.should == 1
      cursor.first["occurrences"].should == 3
    end

    it "transforms hash['groups']['group'] into hash['groups']" do
      @incoming_hash["groups"] = {
        "group" => [{
          "name" => "Variables",
          "attributes" => [{ "key" => "@name", "value" => "Shrink" }]
        }]
      }

      expected_groups = [{
        "name" => "Variables",
        "attributes" => [{ "key" => "@name", "value" => "Shrink" }]
      }]

      Notification.save(@incoming_hash)
      document = Mongo.db[@project_token].find_one
      document["groups"].should == expected_groups
    end

    it "transforms groups ['attributes']['attribute'] into ['attributes']" do
      @incoming_hash["groups"] = [
        {
          "name" => "Variables",
          "attributes" => {
            "attribute" => [{ "key" => "@name", "value" => "Shrink" }]
          }
        },
        {
          "name" => "Backtrace", "display" => "text", "text" => ""
        },
        {
          "name" => "General",
          "attributes" => {
            "attribute" => [{ "key" => "Path", "value" => "/" }]
          }
        }
      ]

      expected_groups = [
        {
          "name" => "Variables",
          "attributes" => [{ "key" => "@name", "value" => "Shrink" }]
        },
        {
          "name" => "Backtrace", "display" => "text", "text" => ""
        },
        {
          "name" => "General",
          "attributes" => [{ "key" => "Path", "value" => "/" }]
        }
      ]

      Notification.save(@incoming_hash)
      document = Mongo.db[@project_token].find_one
      document["groups"].should == expected_groups
    end

    it "wraps groups in an Array" do
      @incoming_hash["groups"] = {
        "group" => { "name" => "General" }
      }

      expected_groups = [{ "name" => "General" }]

      Notification.save(@incoming_hash)
      document = Mongo.db[@project_token].find_one
      document["groups"].should == expected_groups
    end

    it "wraps attributes in an Array" do
      @incoming_hash["groups"] = [
        {
          "name" => "General",
          "attributes" => {
            "attribute" => { "key" => "Path", "value" => "/" }
          }
        }
      ]

      expected_groups = [
        {
          "name" => "General",
          "attributes" => [{ "key" => "Path", "value" => "/" }]
        }
      ]

      Notification.save(@incoming_hash)
      document = Mongo.db[@project_token].find_one
      document["groups"].should == expected_groups
    end

  end

  context "#find" do

    context "selectors" do

      before(:each) do
        Notification.save(@incoming_hash)
        @incoming_hash["id"] = "ece4706c7ffffa7292e7cbf8c8c7e859"
        Notification.save(@incoming_hash)
      end
      
      it "returns an array of all notifications if no selector is given" do
        notifications = Notification.find(@project_token)
        notifications.count.should == 2
        notifications[0].id.should == "3e83a29e908ccef726743cd203da032b"
        notifications[1].id.should == "ece4706c7ffffa7292e7cbf8c8c7e859"
      end

      it "returns all matching notifications for a selector" do
        notifications = Notification.find(@project_token, { :id => "ece4706c7ffffa7292e7cbf8c8c7e859" })
        notifications.count.should == 1
        notifications.first.id.should == "ece4706c7ffffa7292e7cbf8c8c7e859"
      end

    end

  end

  context "groups" do
    
    it "returns an empty array if no groups exist in the document" do
      notification = Notification.new
      notification.groups.should == []
    end

    it "returns all groups if they exist in the document" do
      notification = Notification.new({ "groups" => [{}, {}] })
      notification.groups.count.should == 2
    end

  end

end
