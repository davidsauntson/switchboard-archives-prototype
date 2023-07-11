# frozen_string_literal: true

class Item::ImagesComponent < ViewComponent::Base
  def initialize(entry)
    @entry = entry
  end

  def render?
    image_urls.present?
  end

  def image_urls
    @entry.try(:scan_urls)
  end
end
