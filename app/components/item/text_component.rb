# frozen_string_literal: true

class Item::TextComponent < ViewComponent::Base
  def initialize(entry)
    @entry = entry
    set_renderer
  end

  def text
    @markdown.render(@entry.text)
  end

  def render?
    @entry.try(:text)
  end

  private

  def set_renderer
    renderer = Redcarpet::Render::HTML.new(render_options = {hard_wrap: true})
    @markdown = Redcarpet::Markdown.new(renderer, extensions = {})
  end
end
