module ApplicationHelper
  def authorisation_html
    logged_in = true
    username = "Kvitunov"

    if logged_in
      "Logged in as <b>Kvitunov</b>.<a>Log out</a>".html_safe
    else
      "You are not signed in. <a>Sign up</a> or <a>Sign in</a>".html_safe
    end
  end
end
