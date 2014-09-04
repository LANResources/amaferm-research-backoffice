class AddLinkToSalesAids < ActiveRecord::Migration
  def change
    add_column :sales_aids, :link, :string
  end
end
