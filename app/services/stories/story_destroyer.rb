class Columns::ColumnDestroyer
    include CommonHelper
  
    def initialize(story_id)
      @story = Story.find(story_id)
    end
  
    def call
      @errors = []
      @story.destroy
      
    rescue StandardError => e
      add_error("Failed to destroy the column! Error: #{e.message}")
      { errors: @errors }
    end
  end
  