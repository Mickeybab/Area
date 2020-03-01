from newsapi import NewsApiClient

class newsClient(object):
    def __init__(self):
        self.newsapi = NewsApiClient(api_key='2c7cac11080449ce967568f8c43023be')

    def searchNews(self, query, lang = 'en'):
        res = self.newsapi.get_everything(q=query,
                                    sort_by='popularity',
                                    language=lang,
                                    )
        return res
