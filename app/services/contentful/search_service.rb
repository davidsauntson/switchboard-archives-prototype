# frozen_string_literal: true

module Contentful
  class SearchService
    CONTENTFUL_DELIVERY_API_TOKEN = ENV['CONTENTFUL_DELIVERY_API_TOKEN']
    SPACE_ID = ENV['CONTENTFUL_SPACE_ID']
    ENVIRONMENT = ENV['CONTENTFUL_ENV']

    def initialize(query)
      @query = query
      @cda_client = Contentful::Client.new(
        space: SPACE_ID,
        access_token: CONTENTFUL_DELIVERY_API_TOKEN,
        environment: 'master'
      )
    end

    def results
      @cda_client.entries(query: @query)&.items
    end
  end
end