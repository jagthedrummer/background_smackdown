class SidekiqWorker
  include Sidekiq::Worker

  def perform(job_id)
    start_time = Time.now
    job = Job.find job_id
    job.process(start_time)
  end
end
