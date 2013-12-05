class AddJobCountToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :job_count, :integer
  end
end
