require 'spec_helper'

describe "system_stats/show" do
  before(:each) do
    @system_stat = assign(:system_stat, stub_model(SystemStat,
      :user_cpu => 1.5,
      :sys_cpu => 1.5,
      :load_1 => 1.5,
      :load_5 => 1.5,
      :load_15 => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/1.5/)
  end
end
