class Comments::CommentsPresenter
    include CommonHelper
    
        def initialize(story_id)
          @story = Story.find(story_id)
          @errors = []
        end
      
        def as_json
            @story.comments.map { |comment| Comments::CommentPresenter.new(comment.id).as_json }
        end
      end