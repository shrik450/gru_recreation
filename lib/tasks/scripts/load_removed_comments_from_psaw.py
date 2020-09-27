import json
import datetime as dt

from psaw import PushshiftAPI

api = PushshiftAPI()

file = open("removed_comments.txt", "r")
ids = file.readlines()

processed_comments_count = 0
with open("ps-comments", "w") as file:
    for i in range(0, len(ids), 100):
        comments = api.search_comments(ids=ids[i:i+99])
        for comment in comments:
            processed_comments_count += 1
            print(json.dumps(comment.d_), file=file)
            print(f"Processed {processed_comments_count} comments.", end="\r")
