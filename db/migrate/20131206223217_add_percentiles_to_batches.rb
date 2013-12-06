class AddPercentilesToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :percentile25, :float
    add_column :batches, :percentile75, :float
  end
end
