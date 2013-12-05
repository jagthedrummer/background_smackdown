require 'spec_helper'

describe "batches/new" do
  before(:each) do
    assign(:batch, stub_model(Batch,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new batch form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", batches_path, "post" do
      assert_select "input#batch_name[name=?]", "batch[name]"
    end
  end
end
