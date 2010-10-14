require "spec_helper"

describe Project do

  before(:each) do
    @project = Factory :project
  end

  context "on create" do

    it "generates a unique, random token" do
      @project.token.size.should == 64
    end

  end

  context "on destroy" do

    it "removes all involvements with users" do
      @project.users = 3.times.map { Factory :user }
      Involvement.count.should == 3
      @project.destroy
      Involvement.count.should == 0
    end

  end

  context "notifications" do

    it "can be all fetched" do
      Notification.save({ "id" => "123", "token" => @project.token })
      @project.notifications.count.should == 1
      @project.notifications.first.id.should == "123"
    end

    it "can be fetched according to some criteria" do
      Notification.save({ "id" => "1", "token" => @project.token })
      Notification.save({ "id" => "2", "token" => @project.token })
      notifications = @project.notifications(:id => "2")
      notifications.count.should == 1
      notifications.first.id.should == "2"
    end

  end

end
