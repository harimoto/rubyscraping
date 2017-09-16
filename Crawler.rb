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



