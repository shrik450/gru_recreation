namespace :data do
  desc "Add posting stats from comments and posts"
  task fill_user_posting_stats: :environment do
    puts "Working..."
    total = Author.count
    count = 0
    Author.find_each do |author|
      author
        .posts
        .order(created_utc: :asc)
        .select("*, ROW_NUMBER() OVER (ORDER BY created_utc asc) as n")
        .each do |post|
          post.update(author_n: post.n)
        end
      author.update!(last_post_n: author.posts.maximum(:author_n))
      author
        .comments
        .order(created_utc: :asc)
        .select("*, ROW_NUMBER() OVER (ORDER BY created_utc asc) as n")
        .each do |comment|
          comment.update(author_n: comment.n)
        end
      author.update!(last_comment_n: author.comments.maximum(:author_n))
      count += 1
      print "Processed #{count} authors...\r"
    end
    puts "Processed #{count} authors."
    puts "Done."
  end
end
