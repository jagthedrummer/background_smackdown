require "spec_helper"

describe SystemStatsController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/system_stats").to route_to("system_stats#index")
    end

    it "routes to #new" do
      expect(:get => "/system_stats/new").to route_to("system_stats#new")
    end

    it "routes to #show" do
      expect(:get => "/system_stats/1").to route_to("system_stats#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/system_stats/1/edit").to route_to("system_stats#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/system_stats").to route_to("system_stats#create")
    end

    it "routes to #update" do
      expect(:put => "/system_stats/1").to route_to("system_stats#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/system_stats/1").to route_to("system_stats#destroy", :id => "1")
    end

  end
end
