module ApplicationHelper
  def custom_page_entries_info(collection)
    if collection.length <= 0
      I18n.t("will_paginate.page_entries_info.single_page.zero")
    elsif 1 == collection.length
      I18n.t("will_paginate.page_entries_info.single_page.one")
    else
      I18n.t("will_paginate.page_entries_info.single_page.other", { count: collection.length })
    end
  end

  def on_production_site?
    Rails.env.production? && Figaro.env.production_site.to_bool
  end

  def project_name
    Figaro.env.project_name
  end
end
