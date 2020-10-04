import json
import datetime as dt
from psaw import PushshiftAPI

api = PushshiftAPI()

file = open("hate_authors.txt", "r")
authors = [ author[:-1] for author in file.readlines() ]

processed_authors_count = 1
with open("ps-post-histories", "w") as file:
  for author in authors:
    posts = api.search_submissions(author=author, limit=500)
    subreddits = set([ post.d_["subreddit"] for post in posts ])
    output = {author: list(subreddits)}
    print(json.dumps(output), file=file, end="\n")
    processed_authors_count += 1
    print(f"Processed {processed_authors_count} authors...", end="\r")
    if processed_authors_count % 10 == 0:
      file.flush()
  print(f"Processed {processed_authors_count} authors.", end="\n")
