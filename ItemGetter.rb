require 'open-uri'
require 'nokogiri'
require './HtmlGetter'
require './Item'
require 'pp'

class ItemGetter

  @item_link

  include HtmlGetter

  def initialize(item_link)
    @item_link = item_link
  end

  public def start()
    doc = get_html_contents(@item_link)
    item = get_item(doc)
  end

  private def get_item(doc)
    item = Item.new()

    item.contents_code = get_contents_code()
    item.contents_name = get_contents_name(doc)
    item.summary    = get_summary(doc)

    tds = get_table_elements(doc)

    item.device = get_table_contents(tds, 'デバイス')
    item.actor = get_table_contents(tds, '出演者')

    return item
  end

  private def get_contents_code()
     tmp = @item_link.match(/^.*cid=(\w+)\/.*$/)
     if (tmp != nil)
        return tmp[1]
     else
        return ''
     end
  end

  private def get_contents_name(doc)
    return doc.xpath("//h1[@id='title']").text
  end

  private def get_summary(doc)
    return doc.xpath("//div[@class='mg-b20 lh4']").text
  end

  private def get_table_elements(doc)
    return doc.xpath("//table[@class='mg-b20'] //td")
  end

  def get_table_contents(tds, contents_name)
    hash_key = ''
    contents = ''

    tds.each{|td_ele|

      unless hash_key.empty?
        contents = get_content_from_td_ele(td_ele, hash_key)
        break
      end

      if  td_ele.text.include?(contents_name) then
        hash_key = td_ele.text
      end

    }
    return contents

  end

  private def get_content_from_td_ele(td_ele, hash_key)

     if hash_key.include?('出演者') then
       contents = td_ele.text.gsub(/(\r\n|\r|\n)/, '')
     else
       contents = td_ele.text
     end

     return contents
  end

end
