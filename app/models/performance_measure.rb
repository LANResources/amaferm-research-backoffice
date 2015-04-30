class PerformanceMeasure < ActiveRecord::Base
  belongs_to :trial

  strip_attributes

  validates :measure, presence: true
  validates :control, presence: true
  validates :amaferm, presence: true
  validates :rumensin, presence: { if: Proc.new {|measure| measure.amaferm_rumensin.present? } }
  validates :amaferm_rumensin, presence: { if: Proc.new {|measure| measure.rumensin.present? } }
end
