class Archive
  @queue = :jobs

  def self.perform(job_id)
    job = Job.find job_id
    job.perform
  end
end
