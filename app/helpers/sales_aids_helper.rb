module SalesAidsHelper
  def file_type_icon(sales_aid)
    icon = case sales_aid.file_extension
      when :pdf then 'fa-file-pdf-o'
      when :doc, :docx then 'fa-file-word-o'
      when :ppt, :pptx then 'fa-file-powerpoint-o'
      when :xls, :xlsx then 'fa-file-excel-o'
      else 'fa-file'
      end

    content_tag :i, nil, class: "media-object burntOrange fa fa-3x #{icon}"
  end
end
