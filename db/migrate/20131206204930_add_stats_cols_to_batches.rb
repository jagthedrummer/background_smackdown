class AddStatsColsToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :mean, :float
    add_column :batches, :median, :float
    add_column :batches, :range, :float
    add_column :batches, :min, :float
    add_column :batches, :max, :float
    add_column :batches, :variance, :float
    add_column :batches, :standard_deviation, :float
    add_column :batches, :relative_standard_deviation, :float
    add_column :batches, :percentile95, :float
  end
end
