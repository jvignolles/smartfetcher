module ApplicationHelper
  def on_production_site?
    Rails.env.production? && Figaro.env.production_site.to_bool
  end

  def project_name
    Figaro.env.project_name
  end
end
