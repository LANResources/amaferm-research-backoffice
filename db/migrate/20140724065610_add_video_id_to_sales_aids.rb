class AddVideoIdToSalesAids < ActiveRecord::Migration
  def change
    add_column :sales_aids, :video_id, :string
    add_column :sales_aids, :video_data, :text
  end
end
