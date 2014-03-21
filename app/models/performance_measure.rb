class PerformanceMeasure < ActiveRecord::Base
  belongs_to :trial

  validates :measure, presence: true
  validates :control, presence: true
  validates :amaferm, presence: true
end
