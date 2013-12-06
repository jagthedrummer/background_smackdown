class Job < ActiveRecord::Base

  belongs_to :batch

  def process
    self.started_at = Time.now
    self.start_load_1, self.start_load_5, self.start_load_15 = self.capture_load
    self.start_user_cpu, self.start_sys_cpu = self.capture_cpu
    process_impl
    self.end_load_1, self.end_load_5, self.end_load_15 = self.capture_load
    self.end_user_cpu, self.end_sys_cpu = self.capture_cpu
    self.ended_at = Time.now
    save!
  end

  def process_impl
    # do nothing.  Subclasses will do stuff.
  end

  def capture_load
    %x{uptime}.strip.split(":").last.split(",").map{|load| load.to_f }
  end

  def capture_cpu
    info = %x{top -l 1 -n 0 -s 0 -F -R | grep "CPU usage"}.strip.split
    [ info[2].to_f, info[4].to_f ]
  end

  def runtime
    ended_at - started_at
  end
end
