class AddRumensinToPerformanceMeasures < ActiveRecord::Migration
  def change
    add_column :performance_measures, :rumensin, :string
    add_column :performance_measures, :amaferm_rumensin, :string
  end
end
