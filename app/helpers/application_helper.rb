module ApplicationHelper
  def markdown(text)
    options = [hard_wrap: true]
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML, *options)
    md.render(text).html_safe
  end

  def page_title
    [].tap do |title|
      title << @title if @title
      title << ['Berlin Höfe']
    end.join(' | ')
  end
end
