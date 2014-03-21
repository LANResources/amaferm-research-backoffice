class CreatePerformanceMeasures < ActiveRecord::Migration
  def change
    create_table :performance_measures do |t|
      t.references :trial, index: true
      t.string :measure
      t.string :control
      t.string :amaferm

      t.timestamps
    end
  end
end
