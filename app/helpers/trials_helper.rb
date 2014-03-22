module TrialsHelper
  def display_percentage(value)
    value.blank? ? '' : "#{value}%"
  end
end
