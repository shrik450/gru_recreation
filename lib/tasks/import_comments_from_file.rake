namespace :data do
  desc "Load comments from pushshift dump."
  task import_comments_from_file: :environment do
    file_path = ENV["file_path"]
    subreddit = ENV["subreddit"]

    processed_comments = 0
    open(file_path) do |file|
      # @type [String]
      file.each do |line|
        # @type [Hash{String => String}]
        comment_hash = JSON.parse(line)
        processed_comments += 1
        print "Processed #{processed_comments}...\r"
        next if comment_hash["subreddit"].downcase != subreddit.downcase

        comment_hash = comment_hash.slice(
          "id",
          "body",
          "score",
          "author",
          "subreddit",
          "parent_id",
          "edited",
          "removal_reason",
          "can_gild",
          "can_mod_post",
          "collapsed",
          "collapsed_reason",
          "controversiality",
          "distinguished",
          "is_submitter",
          "no_follow",
          "removed",
          "created_utc"
        )
        comment_hash["created_utc"] = Time.at comment_hash["created_utc"]
        comment_hash["edited"] = !!comment_hash["edited"]
        Comment.create!(**comment_hash.symbolize_keys)
      end
    end
    puts "Processed #{processed_comments}. Done"
  end
end
