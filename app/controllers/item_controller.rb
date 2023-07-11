class ItemController < ApplicationController

  before_action :set_entry

  def show
    return if @entry.blank?
  end

  helper_method :entry
  def entry
    @entry
  end

  private

  def render_item
  end

  def entry_id
    permitted_params[:id]
  end

  def set_entry
    @entry = Contentful::EntryService.new.fetch(entry_id)
  end


  def permitted_params
    params.permit %w[id]
  end
end
