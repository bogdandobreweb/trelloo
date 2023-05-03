class BaseFilter < CommonBase

def call(options: {})
  model.all
end

end