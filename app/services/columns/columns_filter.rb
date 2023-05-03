class Columns::ColumnsFilter < BaseFilter

  def call(options: {})
    return model.all if options.blank?
    
  end
  
  
  
  end