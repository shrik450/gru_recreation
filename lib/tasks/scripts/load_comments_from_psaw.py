import json
import datetime as dt

from psaw import PushshiftAPI

api = PushshiftAPI()

SUBREDDIT = "GamersRiseUp"
START_EPOCH = int(dt.datetime(2019,2,1).timestamp())
END_EPOCH = int(dt.datetime(2020,1,1).timestamp())

comments = api.search_comments(after=START_EPOCH,
                               before=END_EPOCH,
                               subreddit=SUBREDDIT)

processed_comments_count = 0
with open("ps-comments", "w") as file:
    for comment in comments:
      processed_comments_count += 1
      print(json.dumps(comment.d_), file=file)
      print(f"Processed {processed_comments_count} comments.", end="\r")
      if processed_comments_count % 100 == 0:
        file.flush()
