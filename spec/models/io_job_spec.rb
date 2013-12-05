require 'spec_helper'

describe IoJob do

  describe "process" do
    before :each do
      @job = IoJob.new
    end
    it "should take more than two seconds to run" do
      @job.process
      delta = @job.ended_at - @job.started_at
      delta.should be > 2
    end
  end

end
