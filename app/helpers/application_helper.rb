module ApplicationHelper
  def on_production_site?
    Rails.env.production? && Figaro.env.production_site.to_bool
  end
end
