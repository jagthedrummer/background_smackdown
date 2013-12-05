require 'spec_helper'

describe Batch do

  describe "create_jobs" do
    before :each do
      @batch = Batch.create! :job_count => 3, :job_type => "CpuJob"
    end
    it "should create the correct number of jobs" do
      @batch.create_jobs
      @batch.jobs.count.should == @batch.job_count
    end
    it "should create the correct type of jobs" do
      @batch.create_jobs
      @batch.jobs.first.class.name.should == @batch.job_type
    end
  end

end
