class AddModifiedRunToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :modified_run, :boolean, :default => false
  end
end
