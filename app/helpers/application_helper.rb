module ApplicationHelper
  def authorisation_html
    logged_in = true
    username = "Kvitunov"

    if user_signed_in?
      "Logged in as <b>Kvitunov</b>.#{link_to 'Log Out', destroy_user_session_path, :method=>:delete}".html_safe
      
    else
      "You are not signed in. <a>Sign up</a> or <a>Sign in</a>".html_safe
    end
  end

  def is_active_link(path)
    if current_page?(path)
      "class='active'".html_safe
    else
      ""
    end
  end
end
