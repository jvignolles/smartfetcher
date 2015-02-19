class Page < ActiveRecord::Base
  include FetcherConcern

  strip_fields :name, :page_id
  validates :page_id, presence: true

  before_save :validate_page_existence

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
    self.name = page['name']
  end
end
