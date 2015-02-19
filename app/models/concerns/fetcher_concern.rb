# Bundle Facebook fetching
module FetcherConcern
  extend ActiveSupport::Concern

  included do
    attr_accessor :page

    # Fetch feeds and cache it
    def feeds
      return {} if page_id.blank?
      @feeds ||= self.class.graph.get_connections(page_id, 'feed', { fields: [:id, :from, :message, :picture, :created_time], limit: 10 }) rescue {}
    end

    # Fetch page informations and cache it
    def page
      @page ||= self.class.graph.get_object(page_id, { fields: [:id, :name, :picture] }) rescue {}
    end
  end

  module ClassMethods
    def graph
      @graph ||= Koala::Facebook::API.new(Figaro.env.facebook_access_token)
    end

    # Fetch multiple pages to avoid multiple requests
    def fetch_pages
      items = all
      list = graph.get_objects(items.map(&:page_id), { fields: [:id, :name, :picture] })
      items.each do |item|
        item.page = list[item.page_id.to_s]
      end
      items
    end
  end
end
