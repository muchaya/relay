module LinksHelper
  def link_to_active(url, html_options = {}, &block)
    if current_page?(url.to_s)
      html_options[:class] += " " + html_options.delete(:active_class)
    end

    link_to(url, html_options, &block)
  end
end
