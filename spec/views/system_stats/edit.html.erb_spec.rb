require 'spec_helper'

describe "system_stats/edit" do
  before(:each) do
    @system_stat = assign(:system_stat, stub_model(SystemStat,
      :user_cpu => 1.5,
      :sys_cpu => 1.5,
      :load_1 => 1.5,
      :load_5 => 1.5,
      :load_15 => 1.5
    ))
  end

  it "renders the edit system_stat form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", system_stat_path(@system_stat), "post" do
      assert_select "input#system_stat_user_cpu[name=?]", "system_stat[user_cpu]"
      assert_select "input#system_stat_sys_cpu[name=?]", "system_stat[sys_cpu]"
      assert_select "input#system_stat_load_1[name=?]", "system_stat[load_1]"
      assert_select "input#system_stat_load_5[name=?]", "system_stat[load_5]"
      assert_select "input#system_stat_load_15[name=?]", "system_stat[load_15]"
    end
  end
end
