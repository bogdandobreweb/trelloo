module CommonHelper
    def add_error(error)
      @errors ||= []
      @errors << error
    end
    
    def add_success(success)
      @success ||= []
      @success << success
    end
  end