class AddCpuColsToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :start_user_cpu, :float
    add_column :jobs, :start_sys_cpu, :float
    add_column :jobs, :end_user_cpu, :float
    add_column :jobs, :end_sys_cpu, :float
  end
end
