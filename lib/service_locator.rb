module ServiceLocator
  extend self

  def storage
    MemoryStorage
  end
end