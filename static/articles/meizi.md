
``` python

#!/usr/bin/env python

# scrapy web image url
# Created: 2016-07-05
# Copyright: (c) 2016<smileboywtu@gmail.com>


import pprint
import random
import requests
from lxml import html
from string import Template



URL_TEMPLATE = 'http://jandan.net/ooxx/page-$num#comments'


USER_AGENTS = ('Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:11.0) Gecko/20100101 Firefox/11.0',
               'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:22.0) Gecko/20100 101 Firefox/22.0',
               'Mozilla/5.0 (Windows NT 6.1; rv:11.0) Gecko/20100101 Firefox/11.0',
               ('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_4) AppleWebKit/536.5 (KHTML, like Gecko) '
                'Chrome/19.0.1084.46 Safari/536.5'),
               ('Mozilla/5.0 (Windows; Windows NT 6.1) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.46'
                'Safari/536.5'),)


def generate_url(url_template, number):
    """generate url"""
    urls = []
    start, delta = number
    for index in xrange(start, start+delta):
        urls.append(Template(url_template).safe_substitute(num=index))
    return urls

def scrapy_image(parser):
    """scrapy image from parser"""
    urls = parser.xpath("//*[@id='comments']/ol[@class]/li//img/@src")
    return urls


def main(urls):
    """scrap all images on"""
    images = []
    for url in urls:
        page = requests.get(url, headers={'User-Agent': random.choice(USER_AGENTS)}).content
        parser = html.fromstring(page)
        images.extend(scrapy_image(parser))
    images = list(set(images))
    pprint.pprint(images)


if __name__ == '__main__':
    number = (200, 5)
    urls = generate_url(URL_TEMPLATE, number)
    main(urls)
    
```
