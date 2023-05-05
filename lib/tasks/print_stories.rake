namespace :stories do
  desc 'Print all stories'
  task :print_all => :environment do
    stories = Story.all
    stories.each do |story|
      puts "Story ##{story.id}: #{story.name} - #{story.description}"
    end
  end
end