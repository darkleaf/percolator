module ServiceLocator
  extend self

  def storage
    @storage ||= Figaro.env.storage.constantize
  end
end
