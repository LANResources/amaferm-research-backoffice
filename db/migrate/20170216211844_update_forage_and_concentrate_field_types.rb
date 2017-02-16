class UpdateForageAndConcentrateFieldTypes < ActiveRecord::Migration
  def change
    change_column :trials, :forage, :string
    change_column :trials, :concentrate, :string

    reversible do |dir|
      dir.up {
        Trial.all.to_a.each do |trial|
          trial.forage = "#{trial.forage}%" if trial.forage.present?
          trial.concentrate = "#{trial.concentrate}%" if trial.concentrate.present?
          trial.save if trial.forage.present? || trial.concentrate.present?
        end
      }
    end
  end
end
