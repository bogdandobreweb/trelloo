# frozen_string_literal: true

namespace :stories do
  task tasks_agenda: :environment do
    skope = Story.
      where(side_status: "Pending").
      select(:id, :name)

    print skope.to_sql
    skope.find_each do |story|
      puts "Story ##{story.id}: #{story.name}"
    end
  end
  task tasks_agenda2: :environment do
    stories_arr = Story.
      where(side_status: "Pending").
      pluck(:id, :name)

    print stories_arr
    stories_arr.each do |id, name|
      puts "Story #{id}: #{name}"
    end
  end
end
