namespace :data do
  desc "Add authors from comments and posts"
  task backfill_authors: :environment do
    puts "Working..."
    Post.pluck(:author).each do |author_name|
      create_author_if_not_present(author_name)
    end
    Comment.pluck(:author).each do |author_name|
      create_author_if_not_present(author_name)
    end
    puts "Done."
  end

  def create_author_if_not_present(author_name)
    unless Author.find_by(name: author_name)
      Author.create!(name: author_name)
    end
  end
end
