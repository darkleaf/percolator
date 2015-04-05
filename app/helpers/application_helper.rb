module ApplicationHelper
  def markdown(content)
    options = {
      autolink: true,
      fenced_code_blocks: true
    }
    markdown = Redcarpet::Markdown.new Renderer, options
    markdown.render(content).html_safe
  end

  def han(model, attribute)
    model.to_s.classify.constantize.human_attribute_name(attribute)
  end
end
