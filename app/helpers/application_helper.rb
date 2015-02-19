module ApplicationHelper
  FLASH_CLASSES = {
    notice:  "success",
    error:   "danger",
    warning: "warning",
  }

  def custom_page_entries_info(collection)
    if collection.blank? || collection.length <= 0
      I18n.t("will_paginate.page_entries_info.single_page.zero")
    elsif 1 == collection.length
      I18n.t("will_paginate.page_entries_info.single_page.one")
    else
      I18n.t("will_paginate.page_entries_info.single_page.other", { count: collection.length })
    end
  end

  def flash_class(key)
    FLASH_CLASSES[key.to_sym] || "info"
  end

  def i18n_simple_form_label(model, key)
    translation = I18n.t("simple_form.labels.#{model}.#{key}", default: "")
    translation = I18n.t("simple_form.labels.defaults.#{key}", default: "") if translation.blank?
    translation
  end

  def on_production_site?
    Rails.env.production? && Figaro.env.production_site.to_bool
  end

  def project_name
    Figaro.env.project_name
  end
end
