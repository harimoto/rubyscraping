require 'open-uri'
require 'nokogiri'
require './HtmlGetter'

class LinkGetter

  @top_link

  @item_count

  @per_loop

  @max_loop_count

  include HtmlGetter

  def initialize(top_link, per_loop)
    @top_link = top_link
    @per_loop = per_loop || 120
  end

  public def start()
    doc = get_html_contents(@top_link)
    set_loop_count(doc)
    all_links = get_links(doc)
    return all_links
  end

  private def set_loop_count(doc)
    item_count = get_item_count(doc)
    @max_loop_count = item_count.to_i / @per_loop
  end

  def get_item_count(doc)
    item_count_element = doc.xpath("//div[@class='list-boxcaptside list-boxpagenation'] //p").inner_text
    item_count_element2 = item_count_element.match(/^(.*?)タイトル中.*?$/)
    pp item_count_element2[1]
    return item_count_element2[1].delete(",")
  end

  private def get_links(doc)
    all_links = []
    @max_loop_count = 2
    for loop_count in 1..@max_loop_count
      links = get_link_html(loop_count)
      all_links.concat(links)
    end
    return all_links
  end

  private def get_link_html(loop_count)
    url = get_each_url(loop_count)
    links = get_links_each_single_list(url)
    return links
  end

  private def get_each_url(loop_count)
    sprintf "%{top_link}%{pager}%{page_no}", top_link:@top_link,pager:'page=', page_no:loop_count
  end

  private def get_links_each_single_list(url)
    doc = get_html_contents(url)
    #スラッシュの前はスペースあける、
    links = []
    link_eles = doc.xpath('//div[@class="d-item"] //p[@class="tmb"]')
    link_eles.each{|link_ele|
      links.push(link_ele.css('a').attribute('href').text)
    }
    return links
  end

end
