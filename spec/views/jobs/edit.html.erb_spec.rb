require 'spec_helper'

describe "jobs/edit" do
  before(:each) do
    @job = assign(:job, stub_model(Job,
      :batch_id => 1,
      :type => ""
    ))
  end

  it "renders the edit job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", job_path(@job), "post" do
      assert_select "input#job_batch_id[name=?]", "job[batch_id]"
      assert_select "input#job_type[name=?]", "job[type]"
    end
  end
end
