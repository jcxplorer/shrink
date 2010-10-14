require "spec_helper"

describe User do
  

  context "on destroy" do

    it "removes all involvements with project" do
      user = Factory :user
      user.projects = 3.times.map { Factory :project }
      Involvement.count.should == 3
      user.destroy
      Involvement.count.should == 0
    end

  end

end
