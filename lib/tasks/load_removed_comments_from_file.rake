namespace :data do
  desc "Load removed comments from pushshift dump."
  task load_removed_comments_from_file: :environment do
    file_path = ENV["file_path"]

    processed_comments = 0
    open(file_path) do |file|
      # @type [String]
      file.each do |line|
        # @type [Hash{String => String}]
        comment_hash = JSON.parse(line)
        processed_comments += 1
        print "Processed #{processed_comments}...\r"
        comment = Comment.find_by(id: comment_hash["id"])
        if comment.present?
          comment.score = comment_hash["score"]
          comment.body = comment_hash["body"]
          comment.author = comment_hash["author"]
          comment.removed = true
          comment.save!
        end
      end
    end
    puts "Processed #{processed_comments}. Done"
  end
end
