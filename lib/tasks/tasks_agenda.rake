# frozen_string_literal: true

# Excludem toate delivered (side_status) si schimbam din find_each pentru a fi mai eficient

# Tasks ( pluck(:id, :name) )

namespace :stories do
  task tasks_agenda: :environment do
    Story.where(side_status: "Pending").select(:id, :name).find_in_batches do |group|
      group.each do |story|
        puts "Story ##{story.id}: #{story.name}"
      end
    end
  end
end
