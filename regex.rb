require 'pp'

str1 = 'abc123'

str2 = str1.sub(/abc/, 'def')
#=>def123
pp str2

html = <<EOF
<p>1993年2月24日
<a href="http://www.www.yahoo.co.jp">
http://www.yahoo.co.jp
</a>
</p>

<p>2011年11月25日
<a href="http://www.www.yahoo.co.jp">
http://www.yahoo.co.jp
</a>
</p>
EOF

#抽出う
dates = html.scan(/(\d+)年(\d+)月(\d+)日/)
p dates
#=>[["1993", "2", "24"], ["2011", "11", "25"]]

#置換
p 'abc123'.gsub(/[a-z]/,'a'=>'x', 'b'=>'y', 'c'=>'z')
#=>xyz123


p format("%s年%s月%s日",2001,9,11)
#=>"2001年9月11日"

#分割
str2 ="aaa,bb,cc"

arr = str2.split(",")

p arr
#=>["aaa", "bb", "cc"]
#結合
str3 = arr.join("<br>")

p str3
#=>"aaa<br>bb<br>cc"





