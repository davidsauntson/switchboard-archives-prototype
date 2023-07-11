# frozen_string_literal: true

class Item::LocationComponent < ViewComponent::Base
  def initialize(entry)
    @entry = entry
  end

  def section
    @entry.try(:section_number)
  end

  def box 
    @entry.try(:box_number)
  end

  def folder
    @entry.try(:folder_number)
  end
end
