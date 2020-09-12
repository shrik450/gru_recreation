namespace :data do
  desc "Backfills the parent_type field into comments"
  task :backfill_parent_type_to_comments do
    # This can probably be done with a single SQL query
    # But this way is just easier
    Comment.find_each do |comment|
      parent_id = comment.parent_id
      parent_type = if parent_id.starts_with?("t3")
        "Post"
      else
        "Comment"
      end
      parent_id = parent_id[3..]
      comment.update!(parent_id: parent_id, parent_type: parent_type)
    rescue StandardError
      byebug
    end
  end
end
