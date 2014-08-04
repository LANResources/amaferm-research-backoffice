class CreateSupplementals < ActiveRecord::Migration
  def change
    create_table :supplementals do |t|
      t.references :paper, index: true
      t.integer :source_sub_id
      t.string :title
      t.integer :year
      t.references :author, index: true
      t.text :citation
      t.string :literature_type
      t.text :summary
      t.integer :level, default: 0
      t.string :document
      t.string :document_size
      t.string :document_content_type

      t.timestamps
    end
  end
end
