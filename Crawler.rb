require 'open-uri'
require 'anemone'

#rubyクローラー
#対象ドメインの階層をたどる
Anemone.crawl('http://effectorsoyu.net/', :depth_limit => 1) do |anemone|
  #下記は全ページを取得するという意味
  anemone.on_every_page do |page|
    #pageは各リンク情報でオブジェクト
    #page.urlはurl情報
    p page.url
  end
end


#rubyクローラー
Anemone.crawl('http://www.dmm.co.jp/digital/videoa/-/list/=/limit=30/n1=DgRJTglEBQ4G2MaD4Y,d99k_/sort=ranking/', :depth_limit => 1) do |anemone|

  #該当のURL情報のみを取得
  anemone.focus_crawl do |page|
    page.links.keep_if{ |link|
      #正規表現に該当したpageを取得
      link.to_s.match(/.*detail\/=\/cid.*/)
    }
  end

  #上記でヒットしたものをすべて取得する
  anemone.on_every_page do |page|
    #pageは各リンク情報でオブジェクト
    #page.urlはurl情報
    p page.body
    exit
  end
end

