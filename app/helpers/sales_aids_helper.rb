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

  def sales_aid_category_icon(category)
    icon = case category.to_sym
      when :calculator then 'fa-sliders'
      when :video then 'fa-youtube-play'
      else 'fa-files-o'
      end
      
    content_tag :i, nil, class: "fa #{icon}"
  end

  def sales_aid_category(category, options = {})
    display = options.fetch(:plural, false) ? category.pluralize : category 
    display.titleize
      .sub('Newsletter', 'eNewsletter')
      .sub('Documents', 'Specs & Certificates')
      .sub('Document', 'Spec/Certificate')
  end
end
