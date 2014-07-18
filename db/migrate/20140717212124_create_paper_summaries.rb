class CreatePaperSummaries < ActiveRecord::Migration
  def change
    create_table :paper_summaries do |t|
      t.references :trial
      t.string :title
      t.text :description
      t.string :species
      t.boolean :featured, default: 'true'
      t.integer :position
      t.string :document
      t.string :document_size
      t.string :document_content_type

      t.timestamps
    end

    add_index :paper_summaries, :featured
    add_index :paper_summaries, :species
    add_index :paper_summaries, [:featured, :species]
  end
end
