from __future__ import absolute_import, print_function, unicode_literals

import string
import re
from streamparse.bolt import Bolt

################################################################################
# Function to check if the string contains only ascii chars
################################################################################
def ascii_string(s):
  return all(ord(c) < 128 for c in s)

class ParseTweet(Bolt):

    def process(self, tup):
        tweet = tup.values[0]  # extract the tweet

        # Split the tweet into words
        words = tweet.split()

        # Filter out the hash tags, RT, @ and urls
        valid_words = []
        for word in words:

            # Filter the hash tags
            if word.startswith("#"): continue

            # Filter the user mentions
            if word.startswith("@"): continue

            # Filter out retweet tags
            if word.startswith("RT"): continue

            # Filter out the urls
            if word.startswith("http"): continue

            # Strip leading and lagging punctuations
            aword = word.strip("~$-_\"?><,'.:;)")

            # Filter out words that are all punctuations or numbers
            if len([i for i in word if i not in string.punctuation if not i.isdigit()])== 0: continue

            # now check if the word contains only ascii
            if len(aword) > 0 and ascii_string(word):
                valid_words.append([aword.lower()])

        if not valid_words: return

        # Emit all the words
        self.emit_many(valid_words)

        # tuple acknowledgement is handled automatically
