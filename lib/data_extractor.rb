module DataExtractor
  extend self

  def extract(html_string)
    {
      title:  'title',
      description: 'description',
      keywords: 'keywords',
      content: html_string
    }
  end
end
