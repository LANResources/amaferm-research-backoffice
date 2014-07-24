class AddPositionToSalesAids < ActiveRecord::Migration
  def up
    add_column :sales_aids, :position, :integer
    SalesAid.all.group_by(&:category).each do |category, sales_aids|
      sales_aids.each_with_index do |sales_aid, i|
        sales_aid.insert_at i + 1
      end
    end
  end

  def down
    remove_column :sales_aids, :position
  end
end
