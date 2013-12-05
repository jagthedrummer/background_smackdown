class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :batch_id
      t.string :type
      t.timestamp :started_at
      t.timestamp :ended_at

      t.timestamps
    end
  end
end
