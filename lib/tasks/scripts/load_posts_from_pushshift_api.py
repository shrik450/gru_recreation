import datetime as dt

from psaw import PushshiftAPI

api = PushshiftAPI()

SUBREDDIT = "GamersRiseUp"
START_EPOCH = int(dt.datetime(2019,2,1).timestamp())
END_EPOCH = int(dt.datetime(2020,1,1).timestamp())
FIELDS = [
  "id",
  "title",
  "url",
  "selftext",
  "score",
  "author",
  "subreddit",
  "locked",
  "is_self",
  "num_comments",
  "num_crossposts",
  "created_utc",
  "edited",
  "hidden",
  "removal_reason"
]

submissions = api.search_submissions(after=START_EPOCH,
                                     before=END_EPOCH,
                                     subreddit=SUBREDDIT,
                                     filter=FIELDS)

processed_posts_count = 0
with open("ps-submissions", "w") as file:
    file.writelines(submissions)
