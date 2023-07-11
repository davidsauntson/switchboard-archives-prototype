# frozen_string_literal: true

class Item::ItemComponent < ViewComponent::Base
  def initialize(entry)
    @entry = entry
  end
end
