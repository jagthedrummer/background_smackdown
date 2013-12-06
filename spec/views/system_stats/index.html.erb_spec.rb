require 'spec_helper'

describe "system_stats/index" do
  before(:each) do
    assign(:system_stats, [
      stub_model(SystemStat,
        :user_cpu => 1.5,
        :sys_cpu => 1.5,
        :load_1 => 1.5,
        :load_5 => 1.5,
        :load_15 => 1.5
      ),
      stub_model(SystemStat,
        :user_cpu => 1.5,
        :sys_cpu => 1.5,
        :load_1 => 1.5,
        :load_5 => 1.5,
        :load_15 => 1.5
      )
    ])
  end

  it "renders a list of system_stats" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
