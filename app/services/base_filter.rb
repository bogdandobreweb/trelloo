class BaseFilter < CommonBase

  def call(options: {})
    model.all(options)
  end

end