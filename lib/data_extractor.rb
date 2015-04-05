module DataExtractor
  module_function

  def call(html, url)
    doc = Readability::Document.new(html, tags: [])
    {
      url: url,
      title: doc.title.strip,
      description: description(doc.html),
      keywords: keywords(doc.html),
      content: doc.content.strip,
    }
  end

  def description(html)
    max_length = 160
    description = html.search('/html/head/meta[@name="description"]/@content').first.try(:value).to_s
    return if description.length > max_length
    description
  end

  def keywords(html)
    html.search('/html/head/meta[@name="keywords"]/@content').first.try(:value).to_s.split(',')
  end
end
