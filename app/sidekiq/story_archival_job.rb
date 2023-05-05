class StoryArchivalJob
  include Sidekiq::Job

  def perform(*args)
    stories = Story.where.not(delivered_at: nil)

    stories.each do |story|
        story.update(side_status: "Archived")
    end
  end
end