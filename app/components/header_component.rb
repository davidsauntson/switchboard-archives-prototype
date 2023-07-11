# frozen_string_literal: true

class HeaderComponent < ViewComponent::Base

  def show_search?
    !current_page?(root_url) && !current_page?(search_url)
  end
end
