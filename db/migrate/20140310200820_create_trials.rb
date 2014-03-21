class CreateTrials < ActiveRecord::Migration
  def change
    create_table :trials do |t|
      t.references :paper, index: true
      t.string :source_sub_id
      t.integer :level, default: 0
      t.integer :year
      t.text :summary
      t.string :dose
      t.float :forage
      t.float :concentrate
      t.string :species
      t.string :calculations, array: true, default: []

      t.timestamps
    end

    add_index :trials, :year
    add_index :trials, :species
  end
end
