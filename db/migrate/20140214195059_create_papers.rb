class CreatePapers < ActiveRecord::Migration
  def change
    create_table :papers, id: false, primary_key: :source_id do |t|
      t.integer :source_id
      t.text :citation 
      t.integer :level, default: 0
      t.references :author, index: true
      t.integer :year
      t.string :literature_type
      t.string :journal
      t.text :summary
      t.integer :dose
      t.float :forage
      t.float :concentrate
      t.string :document

      t.timestamps
    end

    add_index :papers, :year
    add_index :papers, :literature_type
    add_index :papers, :journal
  end
end
