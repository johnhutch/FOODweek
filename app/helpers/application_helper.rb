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

  def sort_ingredients(ingredients)
    ingredients.sort_by { |name, amount, unit| name }
  end

  def pluralize_ingredient(i)
    if i.unit 
      %Q|<td class="ingredient-table__measurement">#{pluralize(i.numeric_amount, i.unit)}</td>
         <td class="ingredient-table__name">#{i.name}</td>|
    else
      if i.name.split.count > 1
        %Q|<td class="ingredient-table__measurement">#{i.numeric_amount}</td>
          <td class="ingredient-table__name">#{i.name}</td>|
      else
        %Q|<td class="ingredient-table__measurement">#{i.numeric_amount}</td>
          <td class="ingredient-table__name">#{i.name.pluralize(i.numeric_amount)}</td>|
      end
    end
  end

end
