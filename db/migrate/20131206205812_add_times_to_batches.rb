class AddTimesToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :run_time, :float
    add_column :batches, :wall_time, :float
  end
end
