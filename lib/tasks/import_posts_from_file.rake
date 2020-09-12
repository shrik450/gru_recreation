namespace :data do
  desc "Load posts from pushshift dump."
  task import_posts_from_file: :environment do
    file_path = ENV["file_path"]
    subreddit = ENV["subreddit"]

    processed_posts = 0
    open(file_path) do |file|
      # @type [String]
      file.each do |line|
        # @type [Hash{String => String}]
        post_hash = JSON.parse(line)
        processed_posts += 1
        print "Processed #{processed_posts}...\r"
        next if post_hash["subreddit"].downcase != subreddit.downcase

        post_hash = post_hash.slice(
          "id",
          "title",
          "url",
          "selftext",
          "score",
          "author",
          "subreddit",
          "locked",
          "is_self",
          "num_comments",
          "num_crossposts",
          "created_utc",
          "edited",
          "hidden",
          "removal_reason"
        )
        post_hash["created_utc"] = Time.at post_hash["created_utc"]
        post_hash["edited"] = !!post_hash["edited"]
        Post.create!(**post_hash.symbolize_keys)
      end
    end
    puts "Processed #{processed_posts}. Done"
  end
end
