class Columns::ColumnsFilter < BaseFilter
  def call(options: {})
    return model.all if options.blank?

    result = model
    result = result.where(name: options.name) if options.name.present?

    result
  end
end
