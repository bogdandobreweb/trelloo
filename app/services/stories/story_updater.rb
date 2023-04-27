class Columns::ColumnUpdater
    include CommonHelper
  
    def initialize(story_id, params)
      @story = Story.find(story_id)
      @params = params
    end
  
    def call
      @errors = []
      @story.update(@params)
  
      if @story.valid?
        add_success("Column updated successfully!")
        @story
      else
        add_error("Failed to update column! Errors: #{story.errors.full_messages}")
        { errors: @errors }
      end
    end
  end
  