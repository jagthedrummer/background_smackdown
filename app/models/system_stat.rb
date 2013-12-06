class SystemStat < ActiveRecord::Base

  belongs_to :batch

  def capture_load
    %x{uptime}.strip.split(":").last.split(",").map{|load| load.to_f }
  end

  def capture_cpu
    info = %x{top -l 1 -n 0 -s 0 -F -R | grep "CPU usage"}.strip.split
    [ info[2].to_f, info[4].to_f ]
  end

  def capture_info
    self.load_1, self.load_5, self.load_15 = self.capture_load
    self.user_cpu, self.sys_cpu = self.capture_cpu
  end

  def self.capture_current_stats(batch)
    s = batch.system_stats.new
    s.capture_info
    s.save!
  end
  
end
