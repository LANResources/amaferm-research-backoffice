class CreatePapers < ActiveRecord::Migration
  def change
    create_table :papers, id: false, primary_key: :source_id do |t|
      t.integer :source_id
      t.text :citation
      t.string :title
      t.string :location
      t.references :author, index: true
      t.string :literature_type
      t.string :journal
      t.string :document
      t.string :document_size
      t.string :document_content_type

      t.timestamps
    end

    add_index :papers, :literature_type
    add_index :papers, :journal
  end
end
