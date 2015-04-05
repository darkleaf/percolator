module CommonPostMethods
  def to_param
    [id, title].join('-').parameterize
  end

  def to_s
    title
  end
end
