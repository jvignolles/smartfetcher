class Page < ActiveRecord::Base
  include FetcherConcern

  self.per_page = 12

  strip_fields :name, :page_id
  validates :page_id, presence: true, uniqueness: { message: "already exists" }
  validate :validate_page_existence

  scope :alphabetical, -> { order("name, id") }
  scope :ordered, -> { order("created_at desc") }

  def current_name
    page["name"] || name
  end

  def image_url
    (page["picture"] || {})["data"]["url"] rescue nil
  end

private
  # Fetch page and populate `name`
  def validate_page_existence
    if page.blank?
      errors.add(:page_id, :invalid)
      return false
    end
    self.name = page['name']
    true
  end
end
