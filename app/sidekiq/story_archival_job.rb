# frozen_string_literal: true

class StoryArchivalJob
  include Sidekiq::Job

  DELIVERED_START_TIME = 5.minutes.ago

  def perform(*_args)
    stories = Story.where.not(delivered_at: nil)

    stories = stories.where('delivered_at < ?', DELIVERED_START_TIME)

    stories.find_each do |story|
      story.update(side_status: 'Archived')
    end
  end
end
