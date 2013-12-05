class SidekiqWorker
  include Sidekiq::Worker

  def perform(job_id)
    job = Job.find job_id
    job.process
  end
end
