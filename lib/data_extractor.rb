module DataExtractor
  extend self

  ALLOWED_TAGS = %w[figure section article strong em b i p pre code tt samp kbd var sub sup dfn cite big small address
                    span img a hr br div span h1 h2 h3 h4 h5 h6 ol li dl dt dd abbr acronym blockquote del ins].freeze

  ALLOWED_ATTRIBUTES = %w[href src]
  def extract(html_string, url)
    uri = Addressable::URI.parse url
    html = make_absolute_links html_string, uri
    doc = Readability::Document.new(html, tags: ALLOWED_TAGS, attributes: ALLOWED_ATTRIBUTES)

    {
      title: doc.title,
      description: description(doc.html),
      keywords: keywords(doc.html),
      content: doc.content,
      url: url,
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

  def make_absolute_links(html, base_uri)
    # dont work with: src="img.jpg"
    # page coolsite.com/category/page.html
    # correct result:  coolsite.com/category/img.jpg
    # return coolsite.com/img.jpg

    regexp = /(?<attribute>href|src)\s*=\s*(?<q>"|')(?<path>\S+?)\k<q>/

    html.gsub regexp do |match|
      uri_path = Addressable::URI.parse $~[:path]

      if uri_path.relative?
        uri = Addressable::URI.join(base_uri.site, uri_path)
        "#{$~[:attribute]}=\"#{uri}\""
      else
        match
      end
    end
  end
end
