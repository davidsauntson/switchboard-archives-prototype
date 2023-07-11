# frozen_string_literal: true

module Contentful
  class ManagedEntryService
    CONTENTFUL_DELIVERY_API_TOKEN = ENV['CONTENTFUL_DELIVERY_API_TOKEN']
    CONTENTFUL_MANAGEMENT_API_TOKEN = ENV['CONTENTFUL_MANAGEMENT_API_TOKEN']
    SPACE_ID = ENV['CONTENTFUL_SPACE_ID']
    ENVIRONMENT = ENV['CONTENTFUL_ENV']

    def initialize
      @cma_client = Contentful::Management::Client.new(CONTENTFUL_MANAGEMENT_API_TOKEN)
      @environment = @cma_client.environments(SPACE_ID).find(ENVIRONMENT)
    end

    def fetch(entry_id)
      @cma_client.entries(SPACE_ID, @environment.id).find(entry_id)
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
