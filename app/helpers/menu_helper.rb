module MenuHelper
  def menu_link_to(label, path, options = {}, &block)
    icon = content_tag(:i, nil, class: "fa fa-fw fa-#{(options[:icon] || :angle_right).to_s.dasherize}").html_safe
    label = content_tag(:span, p_space(label), class: 'hidden-sm').html_safe
    chevron_down = content_tag(:span, content_tag(:i, nil, class: 'fa fa-chevron-down').html_safe, class: 'label').html_safe

    content_tag :li, class: options[:li_class], data: {active: options[:active_if].join(' ')} do
      if block_given?
        [
          link_to((icon + label + chevron_down).html_safe, '#', class: 'dropmenu').html_safe,
          content_tag(:ul, &block).html_safe
        ].join('').html_safe
      elsif options[:submenu]
        link_to (icon + label).html_safe, path, class: 'submenu'
      else
        link_to (icon + label).html_safe, path
      end
    end.html_safe
  end

  def submenu_link_to(label, path, options = {}, &block)
    menu_link_to label, path, options.merge({submenu: true}), &block
  end

  def page_matches(controllers, actions)
    controllers, actions = Array(controllers), Array(actions)
    return false unless controller.controller_name.in? controllers
    return true unless actions.any?
    params[:action].in? actions
  end
end
