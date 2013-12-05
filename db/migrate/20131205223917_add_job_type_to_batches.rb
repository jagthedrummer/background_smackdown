class AddJobTypeToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :job_type, :string
  end
end
