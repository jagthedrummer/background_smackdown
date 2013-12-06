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

  describe "calculate_wall_time" do
    before :each do
      @batch = Batch.create! :job_count => 3, :job_type => "CpuJob"
      @start_time = Time.now - 2.minutes
      @end_time = Time.now
      @batch.jobs.create!( :started_at => @start_time, :ended_at => @start_time + 20.seconds )
      @batch.jobs.create!( :started_at => @start_time + 30.seconds, :ended_at => @end_time )
    end
    it "should return the difference between the first start time and the last end time in the batch" do
      @batch.calculate_wall_time.should be_within(0.0001).of(@end_time - @start_time)
    end
  end

  describe "calculate_run_time" do
    before :each do
      @batch = Batch.create! :job_count => 3, :job_type => "CpuJob"
      @start_time = Time.now - 2.minutes
      @end_time = Time.now
      @first = @batch.jobs.create!( :started_at => @start_time, :ended_at => @start_time + 20.seconds )
      @last =  @batch.jobs.create!( :started_at => @start_time + 30.seconds, :ended_at => @end_time )
    end
    it "should return the difference between the first start time and the last end time in the batch" do
      @batch.calculate_run_time.should be_within(0.0001).of( @first.runtime + @last.runtime )
    end
  end

  describe "record_stats" do
    before :each do
      @batch = Batch.create! :job_count => 3, :job_type => "CpuJob"
      @start_time = Time.now - 2.minutes
      @end_time = Time.now
      @first = @batch.jobs.create!( :started_at => @start_time, :ended_at => @start_time + 20.seconds )
      @last =  @batch.jobs.create!( :started_at => @start_time + 30.seconds, :ended_at => @end_time )
    end
    it "should capture all the things" do
      @batch.record_stats
      [:mean,:median,:range,:min,:max,:variance,:standard_deviation,:relative_standard_deviation,:run_time, :wall_time].each do |stat|
        puts stat
        @batch.send(stat).should_not be_nil
      end
    end
  end

end
