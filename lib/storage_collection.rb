class StorageCollection
  include Enumerable

  attr_accessor :total_count, :limit_value, :offset_value

  delegate :each, to: :@search_results

  def initialize(search_results, total_count = nil, limit_value = nil, offset_value = nil)
    @search_results = search_results
    @total_count = total_count || @search_results.length
    @limit_value = limit_value || @search_results.length
    @offset_value = offset_value || 0
  end

  def current_page
    return 1 if limit_value == 0
    offset_value / limit_value + 1
  end

  def total_pages
    return 1 if limit_value == 0
    (total_count.to_f / limit_value.to_f).ceil
  end
end
