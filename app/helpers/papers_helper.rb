module PapersHelper
  def render_tags(tag_list, current_scope = {})
    tag_list.map do |tag|
      tags = current_scope.has_key?(:tag) ? current_scope[:tag] : []
      #link_to tag, current_scope.merge({tag: tags | [tag]}), class: 'btn btn-xs btn-default'
      content_tag :span, tag, class: 'label label-default'
    end.join("&nbsp;").html_safe
  end
end