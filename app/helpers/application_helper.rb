module ApplicationHelper
  include Administrate::ApplicationHelper

  def namespace
    "admin"
  end

  def nav_link_state(resource)
    if controller.controller_name == "dashboards" && resource == "dashboard"
      :active
    else
      :inactive
    end
  end
end
