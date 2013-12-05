class Batch < ActiveRecord::Base

  has_many :jobs

  BACKGROUND_TYPES = ["Resque","Sidekiq"]
  JOB_TYPES = ["CpuJob","IoJob"]
  
  def create_jobs
    self.job_count.times do
      self.jobs.create! :type => self.job_type
    end
  end

  def queue_jobs

  end

end
