class ChangeTrackingIdType < ActiveRecord::Migration[6.0]
  def change
    change_column :customers, :tracking_id, :string
  end
end
