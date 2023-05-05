class Stories::StoryUpdater < BaseUpdater
  require '../../sidekiq/story_archival_job.rb'
  def deploy_story
    @story.update(delivered_at: Time.current)
  end

  def check_update_story(story)
    @story = story
    if @story.column_id == 4 
      deploy_story
      StoryArchivalJob.perform_async
      @story
    else
      @story
    end
  end
  @story
end