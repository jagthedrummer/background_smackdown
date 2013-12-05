class AddWorkerAndThreadCountToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :worker_count, :integer
    add_column :batches, :thread_count, :integer
  end
end
