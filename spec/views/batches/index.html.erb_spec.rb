require 'spec_helper'

describe "batches/index" do
  before(:each) do
    assign(:batches, [
      stub_model(Batch,
        :name => "Name"
      ),
      stub_model(Batch,
        :name => "Name"
      )
    ])
  end

  it "renders a list of batches" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
