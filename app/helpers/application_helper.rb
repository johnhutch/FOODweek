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

  def dash_it(text)
    text.gsub!(/_/, '-')
  end

  def format_ingredients(ingredients, sort = nil)
    # takes an array of ingreedy'd ingredients and makes them displayable
    # if sort == true, sort the ingredients

    if sort
      ingredients = ingredients.sort_by { |name, amount, unit| name }
    end

    output = '<ul class="ingredients">'
    ingredients.each do |i|
      output += '<li>' + pluralize(i.numeric_amount, i.unit) + ' ' + i.name + '</li>'
    end
    output += '</ul>'
    output
  end
end
