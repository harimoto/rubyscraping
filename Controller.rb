#!/usr/bin/ruby

#require 'mysql'

#localhostはだめ127.0.0.1
#client= Mysql::new('127.0.0.1', 'root', '', 'rubyscraping')
#result = client.query("SELECT id, name FROM contents ")
#
#result2 = result.fetch
#
#p result2
require 'yaml'
require 'pp'
require './HtmlGetter'
require './LinkGetter'
# スクレイピング先のURL
url = "http://www.dmm.co.jp/digital/videoa/-/list/=/article=keyword/id=1018/sort=ranking/sort=ranking/"
pp url
linkGetter = LinkGetter.new(url, 120)
linkGetter.start();
pp linkGetter

