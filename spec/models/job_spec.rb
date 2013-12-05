require 'spec_helper'

describe Job do

  describe "process" do
    before :each do
      @job = Job.new
    end
    it "should set the started_at and ended_at timestamps" do
      @job.process
      @job.started_at.should_not be_nil
      @job.ended_at.should_not be_nil
    end
    it "should call the process_impl method" do
      @job.should_receive :process_impl
      @job.process
    end
  end

end
