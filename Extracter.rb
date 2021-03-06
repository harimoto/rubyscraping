require 'open-uri'
require 'nokogiri'
require './HtmlGetter'

class Extracter

    def start(topLink)
        htmlGetter = HtmlGetter.new()
        doc = htmlGetter.getHtmlContents(topLink)
   pp doc;
        #総アイテム数を取得
  #      itemCount = getItemCount( doc )
  #      loopCnt = itemCount.to_i / 120
  #
  #      loopCnt=3
  #      for i in 1..loopCnt do
  #
  #          if i >= 2  then
  #              url2 = topLink + "page="+ i.to_s
  #              doc = htmlGetter.getHtmlContents(url2)
  #          end
  #
  #          itemNodes = doc.xpath("//p[@class='tmb']" )
  #
  #          contentsLinks=[]
  #          itemNodes.each{|childrenlist|
  #             contentsLinks.push( childrenlist.css("a").attribute("href").value)
  #          }
  #
  #          itemHashList = getItemHash( contentsLinks )
  #          p itemHashList
  #      end
    end


    def getItemCount( doc )
        itemCountElement = doc.xpath("//div[@class='list-boxcaptside list-boxpagenation'] //p").inner_text
        itemCountElement2 = itemCountElement.match(/^(.*?)タイトル中.*?$/)
        return itemCountElement2[1]
    end


    def getItemHash( contentsLinks )
        itemHashList =[]
        contentsLinks.each{|contentsLink|
            itemHashList.push( makeItemHash( contentsLink ))
        }
        return itemHashList
    end

    def extractItemContents(tds)
        stringTextMode=""
        itemHash ={}

        tds.each{|tdElement|
            itemText = tdElement.text

            if stringTextMode == "performer" then
                itemHash[stringTextMode] = itemText
                stringTextMode=""
            elsif stringTextMode != "" then
                itemHash[stringTextMode] = itemText.gsub(/(\r\n|\r|\n)/, "")
                stringTextMode=""
            end

            if itemText.include?("配信開始日") then
                stringTextMode="delivery_start"
            elsif itemText.include?("対応デバイス") then
                stringTextMode="device"
            elsif itemText.include?("商品発売日") then
                stringTextMode="release_date"
            elsif itemText.include?("収録時間") then
                stringTextMode="duration"
            elsif itemText.include?("出演者") then
                stringTextMode="performer"
            elsif itemText.include?("シリーズ") then
                stringTextMode="series"
            elsif itemText.include?("ジャンル") then
                stringTextMode="jenre"
            elsif itemText.include?("品番") then
                stringTextMode="product_code"
            end
        }
        return itemHash
    end

    def makeItemHash (itemLink)
        htmlGetter = HtmlGetter.new()
        itemHtml = htmlGetter.getHtmlContents(itemLink)
        tds = itemHtml.xpath("//table[@class='mg-b20'] //td")
        itemHash = extractItemContents(tds)
        itemHash["largeImage"] = itemHtml.xpath("//div[@id='sample-video']").css("a").attribute("href").value
        itemHash["contentsName"] = itemHtml.xpath("//h1[@id='title']").text
        itemHash["summary"] = itemHtml.xpath("//div[@class='mg-b20 lh4']").text
        return itemHash
    end

end
