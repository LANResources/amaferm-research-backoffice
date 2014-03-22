class RemoveSpeciesFromTrials < ActiveRecord::Migration
  def up
    rename_column :trials, :species, :x_species

    Trial.all.each do |trial|
      trial.species_list = trial.x_species
      trial.save
    end

    remove_index :trials, :x_species
    remove_column :trials, :x_species
  end

  def down
    add_column :trials, :species, :string, after: :concentrate
    add_index :trials, :species
  end
end
