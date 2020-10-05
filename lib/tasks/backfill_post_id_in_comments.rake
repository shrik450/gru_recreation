namespace :data do
  desc "Backfill post id into comments."
  task backfill_post_id_in_comments: :environment do
    processed_comments_count = 0
    total_comments_count = Comment.count
    Comment.find_each do |comment|
      parent = comment.parent
      next if parent.blank? # This can happen if the post is before our study range.

      current_comment = comment
      while current_comment.parent_type != "Post"
        current_comment = parent
        parent = current_comment.parent
        break if parent.blank?
      end
      next if parent.blank?

      comment.update!(post_id: parent.id)
      processed_comments_count += 1
      print "Processed #{processed_comments_count}/#{total_comments_count} comments...\r"
    end
    puts "Processed #{processed_comments_count}/#{total_comments_count} comments. Done."
  end
end
