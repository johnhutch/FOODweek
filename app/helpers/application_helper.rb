module ApplicationHelper
  def markdown(text)
    # Settings for the markdown.render method to use.
    renderer = Redcarpet::Render::HTML.new(
      filter_html: true,
      no_images: true,
      no_links: true,
      no_styles: true,
      hard_wrap: true,
      prettify: true,
    )

    markdown = Redcarpet::Markdown.new(
      renderer,
      no_intra_emphasis: true,
      strikethrough: true,
      lax_spacing: true
    )

    markdown.render(text).html_safe
  end
end
