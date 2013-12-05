require 'spec_helper'

describe "jobs/new" do
  before(:each) do
    assign(:job, stub_model(Job,
      :batch_id => 1,
      :type => ""
    ).as_new_record)
  end

  it "renders new job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", jobs_path, "post" do
      assert_select "input#job_batch_id[name=?]", "job[batch_id]"
      assert_select "input#job_type[name=?]", "job[type]"
    end
  end
end
