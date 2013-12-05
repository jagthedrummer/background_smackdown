class Job < ActiveRecord::Base

  belongs_to :batch

  def process
    self.started_at = Time.now
    process_impl
    self.ended_at = Time.now
    save!
  end

  def process_impl
    # do nothing.  Subclasses will do stuff.
  end

end
