class Job < ActiveRecord::Base
  belongs_to :batch

  def process(start_time)
    self.started_at = start_time
    process_impl
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
