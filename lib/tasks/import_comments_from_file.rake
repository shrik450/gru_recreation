namespace :data do
  desc "Load comments from pushshift dump."
  task import_comments_from_file: :environment do
    file_path = ENV["file_path"]
    subreddit = ENV["subreddit"]
    bq = ENV["bq"]

    if bq
      process_bq_json(file_path)
    else
      process_ps_file(file_path, subreddit)
    end
  end

  def process_ps_file(file_path, subreddit)
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
        parent_id = comment_hash["parent_id"]
        comment_hash["parent_type"] = if parent_id.starts_with?("t3")
          "Post"
        else
          "Comment"
        end
        comment_hash["parent_id"] = parent_id[3..]
        Comment.create!(**comment_hash.symbolize_keys)
      end
    end
    puts "Processed #{processed_comments}. Done"
  end

  def process_bq_json(file_path)
    processed_comments = 0
    open(file_path) do |file|
      # Bigquery json export is a single json array or comments.
      comment_array = JSON.parse(file.read)
      comment_array.each do |comment_hash|
        processed_comments += 1
        print "Processed #{processed_comments}...\r"
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
        comment_hash["created_utc"] = Time.at comment_hash["created_utc"].to_f
        comment_hash["edited"] = !!comment_hash["edited"]
        parent_id = comment_hash["parent_id"]
        comment_hash["parent_type"] = if parent_id.starts_with?("t3")
          "Post"
        else
          "Comment"
        end
        comment_hash["parent_id"] = parent_id[3..]
        Comment.create!(**comment_hash.symbolize_keys)
      end
    end
    puts "Processed #{processed_comments}. Done"
  end
end
