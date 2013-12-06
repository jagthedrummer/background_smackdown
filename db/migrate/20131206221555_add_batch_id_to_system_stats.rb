class AddBatchIdToSystemStats < ActiveRecord::Migration
  def change
    add_column :system_stats, :batch_id, :integer
  end
end
