# Bundle Facebook fetching
module FetcherConcern
  extend ActiveSupport::Concern

  included do
    # Fetch feeds and cache it
    def feeds
      return nil if page_id.blank?
      @feeds ||= self.class.graph.get_connections(page_id, 'feed', { limit: 10 })
    end

    # Fetch page informations and cache it
    def page
      @page ||= self.class.graph.get_object(page_id, { fields: [:id, :name, :picture] })
    end
  end

  module ClassMethods
    def graph
      @graph ||= Koala::Facebook::API.new(Figaro.env.facebook_access_token)
    end

    def pages(page_ids)
      graph.get_object(page_ids)
    end
  end
end
