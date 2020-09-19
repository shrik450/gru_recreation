import json
import datetime as dt

from psaw import PushshiftAPI

api = PushshiftAPI()

SUBREDDIT = "GamersRiseUp"
START_EPOCH = int(dt.datetime(2019,9,1).timestamp())
END_EPOCH = int(dt.datetime(2020,1,1).timestamp())

submissions = api.search_submissions(after=START_EPOCH,
                                     before=END_EPOCH,
                                     subreddit=SUBREDDIT)

processed_posts_count = 0
with open("ps-submissions", "w") as file:
    for submission in submissions:
      processed_posts_count += 1
      print(json.dumps(submission.d_), file=file)
      print(f"Processed {processed_posts_count} posts.", end="\r")
      if processed_posts_count % 100 == 0:
        file.flush()
