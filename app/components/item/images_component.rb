# frozen_string_literal: true

class Item::ImagesComponent < ViewComponent::Base
  def initialize(entry)
    @entry = entry
  end

  def image_urls
    @entry.scan_urls
  end
end
