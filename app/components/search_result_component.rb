# frozen_string_literal: true

class SearchResultComponent < ViewComponent::Base
  def initialize(search_result)
    @search_result = search_result
  end

  def url
    "/item/#{@search_result.id}"
  end

  def title
    @search_result.title
  end

  def content_type
    @search_result.content_type.id.uppercase
  end
end
