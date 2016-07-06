
``` python

#!/usr/bin/env python

# scrapy web image url
# Created: 2016-07-05
# Copyright: (c) 2016<smileboywtu@gmail.com>


import os
import time
import random
import pprint
import urllib2
from lxml import html
from string import Template

import gevent
# use gevent socket
import gevent.monkey
gevent.monkey.patch_all()


USER_AGENTS = ('Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:11.0) Gecko/20100101 Firefox/11.0',
               'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:22.0) Gecko/20100 101 Firefox/22.0',
               'Mozilla/5.0 (Windows NT 6.1; rv:11.0) Gecko/20100101 Firefox/11.0',
               ('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_4) AppleWebKit/536.5 (KHTML, like Gecko) '
                'Chrome/19.0.1084.46 Safari/536.5'),
               ('Mozilla/5.0 (Windows; Windows NT 6.1) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.46'
                'Safari/536.5'),)

IMAGE_FILE_DIR = 'e:/images'
URL_TEMPLATE = 'http://jandan.net/ooxx/page-$num#comments'
REQ_TIMEOUT = 15

START_PAGE = 1456 # when set this you should go to jiandan.com to see the max tab value
PAGE_DELTA = 2


def construct_req(url):
    """
    construct the req use url

    :param url: url to construct
    :return: urllib2 req
    """
    random.seed(time.time())
    req = urllib2.Request(url, headers={'User-Agent': random.choice(USER_AGENTS)})
    return req


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


def scrapy_image(url):
    """
    scrapy the image url from the page source

    :param url: page url
    :return: image urls list
    """
    req = construct_req(url)
    page = urllib2.urlopen(req).read()
    parser = html.fromstring(page)
    urls = parser.xpath("//*[@id='comments']/ol[@class='commentlist']/li//img/@src")
    return urls


def download_image(urls):
    """
    download the image from given urls

    :param urls: image urls
    :return: None
    """
    counter = 0
    def _download(url):
        req = construct_req(url)
        resp = urllib2.urlopen(req, timeout=REQ_TIMEOUT)
        if resp.getcode() == 200:
            # path construct
            filename = url.split('/')[-1]
            path = os.path.join(IMAGE_FILE_DIR, filename)
            with open(path, 'wb') as fp:
                fp.write(resp.read())
            return 1
        return 0

    jobs = [gevent.spawn(_download, url) for url in urls]
    gevent.joinall(jobs)

    for job in jobs:
        try:
            counter += job.value
        except TypeError:
            pass
    print 'image download process done, %d images downloaded and saved to %s' % (counter, IMAGE_FILE_DIR)


def main():
    """
    main func

    :return: None
    """
    images = []
    number = (START_PAGE, PAGE_DELTA) # start, delta
    urls = generate_url(URL_TEMPLATE, number)
    jobs = [gevent.spawn(scrapy_image, url) for url in urls]
    gevent.joinall(jobs)
    for job in jobs:
        job.value and images.extend(job.value)
    # return none duplicate item
    images = list(set(images))
    print '%d images will be download. they are: ' % len(images)
    pprint.pprint(images)
    print 'start to download image...'
    download_image(images)


if __name__ == '__main__':
    main()
    
```
