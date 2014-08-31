FactoryGirl.define do
  sequence :page_attributes do
    {
      title: FactoryGirl.generate(:title),
      description: FactoryGirl.generate(:description),
      keywords: 5.times.map{FactoryGirl.generate(:string)}.join(','),
      content: FactoryGirl.generate(:content)
    }
  end

  sequence :page_html do
    page_attributes = FactoryGirl.generate :page_attributes
    page_template_path = fixture_file_path('page.html.haml')
    page_template = open(page_template_path).read

    Haml::Engine.new(page_template).render(Object.new, page_attributes)
  end
end
