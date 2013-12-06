require 'spec_helper'

describe "SystemStats" do
  describe "GET /system_stats" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get system_stats_path
      expect(response.status).to be(200)
    end
  end
end
