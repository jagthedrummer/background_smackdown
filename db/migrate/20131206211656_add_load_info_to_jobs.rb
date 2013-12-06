class AddLoadInfoToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :start_load_1, :float
    add_column :jobs, :start_load_5, :float
    add_column :jobs, :start_load_15, :float
    add_column :jobs, :end_load_1, :float
    add_column :jobs, :end_load_5, :float
    add_column :jobs, :end_load_15, :float
  end
end
