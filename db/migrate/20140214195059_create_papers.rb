class CreatePapers < ActiveRecord::Migration
  def change
    create_table :papers, id: false, primary_key: :source_id do |t|
      t.string :source_id
      t.string :citation 
      t.integer :level, default: 0
      t.references :author, index: true
      t.integer :dose
      t.integer :year
      t.string :literature_type
      t.string :journal
      t.text :species, array: true, default: []
      t.float :forage
      t.float :concentrate
      t.string :document

      t.timestamps
    end

    add_index :papers, :year
    add_index :papers, :literature_type
    add_index :papers, :journal
    add_index :papers, :species, using: 'gin'
  end
end
