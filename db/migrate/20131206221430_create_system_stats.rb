class CreateSystemStats < ActiveRecord::Migration
  def change
    create_table :system_stats do |t|
      t.float :user_cpu
      t.float :sys_cpu
      t.float :load_1
      t.float :load_5
      t.float :load_15

      t.timestamps
    end
  end
end
