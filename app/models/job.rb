class Job < ActiveRecord::Base

  belongs_to :batch

  def process(start_time)
    self.started_at = start_time
    #self.start_load_1, self.start_load_5, self.start_load_15 = self.capture_load
    #self.start_user_cpu, self.start_sys_cpu = self.capture_cpu
    process_impl
    #self.end_load_1, self.end_load_5, self.end_load_15 = self.capture_load
    #self.end_user_cpu, self.end_sys_cpu = self.capture_cpu
    self.ended_at = Time.now
    save!
  end

  def process_impl
    # do nothing.  Subclasses will do stuff.
  end

  

  def runtime
    ended_at - started_at rescue nil
  end
end
