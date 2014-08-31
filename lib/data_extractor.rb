module DataExtractor
  extend self

  ALLOWED_TAGS = %w[figure section article strong em b i p pre code tt samp kbd var sub sup dfn cite big small address
                    span img a hr br div span h1 h2 h3 h4 h5 h6 ol li dl dt dd abbr acronym blockquote del ins].freeze

  ALLOWED_ATTRIBUTES = %w[href src]
  def extract(html_string)
    doc = Readability::Document.new(html_string, tags: ALLOWED_TAGS, attributes: ALLOWED_ATTRIBUTES)

    {
      title: doc.title,
      description: description(doc.html),
      keywords: keywords(doc.html),
      content: doc.content
    }
  end

private
  def description(html)
    max_length = 160
    description = html.search('/html/head/meta[@name="description"]/@content').first.try(:value).to_s
    return '' if description.length > max_length
    description
  end

  def keywords(html)
    html.search('/html/head/meta[@name="keywords"]/@content').first.try(:value).to_s
  end
end
