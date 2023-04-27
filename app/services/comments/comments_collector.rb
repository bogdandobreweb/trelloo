class Comments::CommentsCollector
    include CommonHelper
    attr_reader :errors

    def initialize(story_id)
      @story = Story.find(story_id)
    end
  
    def call
        @errors = []
        @comments = @story.comments
        add_success("Comments fetched successfully!")
        @comments
        rescue StandardError => e
        add_error("Failed to fetch comments! Error: #{e.message}")
        end
    end
end