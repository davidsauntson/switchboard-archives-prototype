# frozen_string_literal: true

module Contentful
  class EntryService
    CONTENTFUL_DELIVERY_API_TOKEN = ENV['CONTENTFUL_DELIVERY_API_TOKEN']
    SPACE_ID = ENV['CONTENTFUL_SPACE_ID']
    ENVIRONMENT = ENV['CONTENTFUL_ENV']

    def initialize
      @cda_client = Contentful::Client.new(
        space: SPACE_ID,
        access_token: CONTENTFUL_DELIVERY_API_TOKEN,
        environment: 'master'
      )
    end

    def fetch_all(content_type)
      query.merge(content_type: content_type)
      cda_client.entries(query)
    end

    private

    attr_reader :cda_client

    def query
      {
        order: 'sys.createdAt',
        include: 0
      }
    end
  end
end
