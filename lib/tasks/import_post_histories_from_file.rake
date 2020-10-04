namespace :data do
  desc "Load post histories from pushshift dump."
  task import_post_histories_from_file: :environment do
    file_path = ENV["file_path"]
    open(file_path) do |file|
      file.each do |line|
        post_history = JSON.parse(line)
        author = Author.find(post_history.keys.first)
        author.update!(subreddit_history: post_history[author.name])
      end
    end
  end
end
