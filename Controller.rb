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
require './ItemGetter'
require './LinkGetter'

# スクレイピング先のURL
#url = 'http://www.dmm.com/digital/cinema/-/list/=/limit=30/sort=date/';
#   linkGetter = LinkGetter.new(url, 120)
#pp linkGetter.start()

url = 'http://www.dmm.com/digital/cinema/-/detail/=/cid=5116tcbd06332/?i3_ref=list&i3_ord=8';
itemGetter = ItemGetter.new(url)
pp itemGetter.start()

