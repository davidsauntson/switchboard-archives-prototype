# frozen_string_literal: true

class Item::LocationComponent < ViewComponent::Base
  def initialize(entry)
    @entry = entry
  end

  def section
    @entry.section_number
  end

  def box 
    @entry.box_number
  end

  def folder
    @entry.folder_number
  end
end
