module UsersHelper
  def role_label(user)
    content_tag :span, user.role.titleize, class: 'label label-info user-status-label'
  end

  def show_role_select?(user)
    user.new_record? || current_user > user
  end

  def role_explanations(roles)
    content_tag :dl, class: 'dl-horizontal', id: 'role-explanations' do
      roles.map do |role|
        dt = content_tag :dt, role.to_s.titleize
        explanation = case role.to_s.titleize
                      when 'Public Sales'
                        ['Can only view public-level research papers.',
                          'Can access public-sales-level sales aids.'].join('<br/>')
                      when 'Basic'
                        'Can only view public and shared-level research papers.'
                      when 'Basic Manager'
                        'Can create/invite new basic users.'
                      when 'Biozyme'
                        ['Can create/invite new users.',
                          'Can view all research papers.'].join('<br/>')
                      when 'Manager'
                        'Can create/manage research papers.'
                      when 'Admin'
                        'Full permissions'
                      end
        dd = content_tag :dd, (explanation + ' <hr/>').html_safe
        [dt + dd].join('').html_safe
      end.join('').html_safe
    end.html_safe
  end
end
