class CreateSalesAids < ActiveRecord::Migration
  def change
    create_table :sales_aids do |t|
      t.string :title
      t.references :user, index: true
      t.string :category
      t.integer :access_level, default: 0
      t.string :document
      t.string :document_size
      t.string :document_content_type

      t.timestamps
    end

    add_index :sales_aids, :category
    add_index :sales_aids, :access_level
  end
end
