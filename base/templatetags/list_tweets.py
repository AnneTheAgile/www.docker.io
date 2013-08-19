__author__ = 'thatcher'

from django import template
from base.utils import TwitterClient
import json
from django.core.cache import get_cache


cache = get_cache('disk_cache')

# from django.core.urlresolvers import reverse
# import re

register = template.Library()

CONSUMER_KEY = 'aEtFq69wvzUAjlzwh9Tw'
CONSUMER_SECRET = 'o6mcmOLtp35loXfUbRBOVpyfzenFdOSwBV3jd4MMFSM'
TWITTER_TIMEOUT = 3600 * 24 * 3



# @register.tag(name="list_tweets")

@register.tag
def list_tweets(parser, token):
    """
    Tag written to fetch the tweets from tweet id's. expects a plain list of tweet id's newline separated.

    ~tp
    """

    nodelist = parser.parse(('end_list_tweets',))
    parser.delete_first_token()
    tweets = TweetNode(nodelist)
    return tweets

class TweetNode(template.Node):
    def __init__(self, nodelist):
        self.nodelist = nodelist
    def render(self, context):
        output = self.nodelist.render(context)

        items = output.split()

        tweet = {}
        tweets = []
        html = ""

        try:

            for item in items:
                tweet = cache.get(item)

                if tweet:
                    pass
                else:
                    twitter_client = TwitterClient(CONSUMER_KEY, CONSUMER_SECRET)
                    print item

                    tweet = twitter_client.request('https://api.twitter.com/1.1/statuses/show.json?id={0}'.format(item))
                    cache.set(item, tweet, TWITTER_TIMEOUT)

                data = json.loads(tweet)

                html += """
                <div class="tweet" onClick="window.open('http://twitter.com/{2}/status/{4}/')" >
                    <img src="{0}">
                    <span class="username">{1}</span>
                    <span class="handle" ><a onClick="window.open('http://twitter.com/{2}'); event.preventDefault();" href="https://twitter.com/{2}/" title="users twitter page">@{2}</a></span>
                    <p><span class="text">{3}</span></p>
                </div>

                """.format(
                    data['user']['profile_image_url'].replace("http://a0", "https://si0"),
                    data['user']['name'].encode('utf-8').strip(),
                    data['user']['screen_name'].encode('utf-8').strip(),
                    data['text'].encode('utf-8').strip(),
                    data['id']
                )
        except:
            html = "oops.. we failed to get some tweets from the api, but believe us, it's all good. :-)"

        return html