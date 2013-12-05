class ResqueWorker
  @queue = :jobs

  def self.perform(job_id)
    job = Job.find job_id
    job.process
  end
end
