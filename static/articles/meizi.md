
``` python

#!/usr/bin/env python

# scrapy web image url
# Created: 2016-07-05
# Copyright: (c) 2016<smileboywtu@gmail.com>


import os
import shutil
import random
import pprint
import requests
from lxml import html
from string import Template

USER_AGENTS = ('Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:11.0) Gecko/20100101 Firefox/11.0',
               'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:22.0) Gecko/20100 101 Firefox/22.0',
               'Mozilla/5.0 (Windows NT 6.1; rv:11.0) Gecko/20100101 Firefox/11.0',
               ('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_4) AppleWebKit/536.5 (KHTML, like Gecko) '
                'Chrome/19.0.1084.46 Safari/536.5'),
               ('Mozilla/5.0 (Windows; Windows NT 6.1) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.46'
                'Safari/536.5'),)

IMAGE_FILE_DIR = 'e:/images'
URL_TEMPLATE = 'http://jandan.net/ooxx/page-$num#comments'

START_PAGE = 100 # when set this you should go to jiandan.com to see the max tab value
PAGE_DELTA = 5


def generate_url(url_template, number):
    """
    construct scrapy source urls

    :param url_template: url template for jiandan
    :param number: jiandan.com source tab range
    :return: scrapy urls
    """
    urls = []
    start, delta = number
    for index in xrange(start, start+delta):
        urls.append(Template(url_template).safe_substitute(num=index))
    return urls


def scrapy_image(parser):
    """
    scrapy the image url from the page source

    :param parser: lxml.html parser
    :return: image urls list
    """
    urls = parser.xpath("//*[@id='comments']/ol[@class='commentlist']/li//img/@src")
    return urls


def download_image(urls):
    """
    download the image from given urls

    :param urls: image urls
    :return: None
    """
    counter = 0

    for url in urls:
        resp = requests.get(url, stream=True)
        if resp.status_code == 200:
            counter += 1
            # path construct
            filename = url.split('/')[-1]
            path = os.path.join(IMAGE_FILE_DIR, filename)
            with open(path, 'wb') as fp:
                resp.raw.decode_content = True
                shutil.copyfileobj(resp.raw, fp)
    print 'image download process done, %d images downloaded and saved to %s' % (counter, IMAGE_FILE_DIR)


def main():
    """
    main func

    :return: None
    """
    images = []
    number = (START_PAGE, PAGE_DELTA) # start, delta
    urls = generate_url(URL_TEMPLATE, number)
    for url in urls:
        page = requests.get(url, headers={'User-Agent': random.choice(USER_AGENTS)}).content
        parser = html.fromstring(page)
        images.extend(scrapy_image(parser))
    # return none duplicate item
    images = list(set(images))
    print '%d images will be download. they are: ' % len(images)
    pprint.pprint(images)
    print 'start to download image...'
    download_image(images)


if __name__ == '__main__':
    main()
    
```
