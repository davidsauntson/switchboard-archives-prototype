# frozen_string_literal: true

class SearchController < ApplicationController
  before_action :set_search_results

  def index; end

  private

  def set_search_results
    return if query.blank?

    @search_results ||= ::Contentful::SearchService.new(query).results
  end

  helper_method :query
  def query
    permitted_params[:q]
  end

  def permitted_params
    params.permit %w[q]
  end
end
