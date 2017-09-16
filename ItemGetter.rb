require 'open-uri'
require 'nokogiri'
require './HtmlGetter'
require './Item'
require 'pp'

class ItemGetter

  @itemLink

  include HtmlGetter
  def initialize(itemLink)
    @itemLink = itemLink
  end

  public def start()
    doc = getHtmlContents(@itemLink)
    item = getItem(doc)
  end

  private def getItem(doc)
    item = Item.new()

    item.contentsCode = getContentsCode()
    item.contentsName = getContentsName(doc)
    item.summary    = getSummary(doc)

    return item
  end

  private def getContentsCode()
     tmp = @itemLink.match(/^.*cid=(\w+)\/.*$/)
     if (tmp != nil)
        return tmp[1]
     else
        return ''
     end
  end

  private def getContentsName(doc)
    return doc.xpath("//h1[@id='title']").text
  end

  private def getSummary(doc)
    return doc.xpath("//div[@class='mg-b20 lh4']").text
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
