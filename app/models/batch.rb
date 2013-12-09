class Batch < ActiveRecord::Base

  has_many :jobs, -> { order "created_at asc" }
  has_many :system_stats, -> { order "created_at asc" }

  BACKGROUND_TYPES = ["Resque","Sidekiq"]
  JOB_TYPES = ["Job","CpuJob","IoJob","MixedJob"]
  
  def create_jobs
    self.job_count.times do
      self.jobs.create! :type => self.job_type
    end
  end


  def clean_children
    self.jobs.destroy_all
    self.system_stats.destroy_all
  end

  def process_batch
    SystemStat.capture_current_stats(self)
    self.queue_jobs
    while( !self.finished? )
      self.reload
      SystemStat.capture_current_stats(self)
      sleep(0.5)
    end
  end

  def finished?
    self.jobs.where(:ended_at => nil).count == 0
  end

  def queue_jobs
    self.jobs.find_each do |job|
      if self.background_type == "Resque"
        Resque.enqueue(ResqueWorker, job.id)
      else
        SidekiqWorker.perform_async(job.id)
      end
    end
  end

  def runtime_data
    self.jobs.map{|j| j.ended_at - j.started_at }
  end

  def statistical_data
    @sdata ||= DescriptiveStatistics::Stats.new(runtime_data)
  end

  def calculate_wall_time
    first = self.jobs.order("started_at asc").first
    last = self.jobs.order("ended_at desc").first
    last.ended_at - first.started_at
  end

  def calculate_run_time
    self.jobs.map{|j| j.ended_at - j.started_at }.inject(:+)
  end

  def record_stats
    self.wall_time = calculate_wall_time
    self.run_time = calculate_run_time
    [:mean,:median,:range,:min,:max,:variance,:standard_deviation,:relative_standard_deviation].each do |stat|
      self[stat] = statistical_data.send(stat)
    end
    self.percentile95 = statistical_data.value_from_percentile(95)
    self.percentile25 = statistical_data.value_from_percentile(25)
    self.percentile75 = statistical_data.value_from_percentile(75)
  end

end
