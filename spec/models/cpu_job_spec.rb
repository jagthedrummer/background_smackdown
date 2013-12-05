require 'spec_helper'

describe CpuJob do

  describe "process" do
    before :each do
      @job = CpuJob.new
    end
    it "should take more than two seconds to run" do
      @job.process
      delta = @job.ended_at - @job.started_at
      puts "CpuJob delta = #{delta}"
      delta.should be > 2
    end
  end

end
