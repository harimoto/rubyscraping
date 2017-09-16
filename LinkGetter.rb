require 'open-uri'
require 'nokogiri'
require './HtmlGetter'

class LinkGetter

  @topLink

  @itemCount

  @perLoop

  @maxLoopCount

  include HtmlGetter

  def initialize(topLink, perLoop)
    @topLink = topLink
    @perLoop = perLoop || 120
  end

  public def start()
    doc = getHtmlContents(@topLink)
    setLoopCount(doc)
    allLinks = getLinks(doc)
    return allLinks
  end

  private def setLoopCount(doc)
    itemCount = getItemCount(doc)
    @maxLoopCount = itemCount.to_i / @perLoop
  end

  def getItemCount( doc )
    itemCountElement = doc.xpath("//div[@class='list-boxcaptside list-boxpagenation'] //p").inner_text
    itemCountElement2 = itemCountElement.match(/^(.*?)タイトル中.*?$/)
    pp itemCountElement2[1]
    return itemCountElement2[1].delete(",")
  end

  private def getLinks(doc)
    allLinks = []
    @maxLoopCount = 2
    for loopCount in 1..@maxLoopCount do
      links = getLinkHtml(loopCount)
      allLinks.concat(links)
    end
    return allLinks
  end

  private def getLinkHtml(loopCount)
    url = getEachUrl(loopCount)
    links = getLinksEachSingleList(url)
    return links
  end

  private def getEachUrl(loopCount)
    sprintf "%{topLink}%{pager}%{pageNo}" , topLink:@topLink ,pager:'page=', pageNo:loopCount
  end

  private def getLinksEachSingleList(url)
    doc = getHtmlContents(url)
    #スラッシュの前はスペースあける、
    links = []
    linkEles = doc.xpath('//div[@class="d-item"] //p[@class="tmb"]')
    linkEles.each{|linkEle|
      links.push(linkEle.css('a').attribute('href').text)
    }
    return links
  end

end
