class AddBackgroundTypeToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :background_type, :string
  end
end
