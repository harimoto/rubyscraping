require 'pp'

arr = [1,2,3]

arr2 = [3, 4, 5, 6]
arr3 = arr2.map {|i| i + 1 }
p arr3
#=>[4, 5, 6, 7]

arr4=[
  {"name"=>" kazumi", "domain"=>"gmail.com",  "age"=>"30","pref"=>"chiba"},
  {"name"=>"ichirou","domain"=>"yahoo.co.jp", "age"=>"18","pref"=>"tokyo"},
  {"name"=>" yuusuke","domain"=>"hotmail.com", "age"=>"25","pref"=>"chiba"},
  {"name"=>" satoshi","domain"=>"gmail.com", "age"=>"45","pref"=>"kanagawa"},
  {"name"=>"jirou ",  "domain"=>"hotmail.com", "age"=>"9","pref"=>"tokyo"}
]


arr4.select{|person| person['age'].to_i  >= 30 }
    .map{|person| person['mail'] = person['name'] + '@'+ person['domain']}

pp arr4
=begin
[{"name"=>" kazumi",
  "domain"=>"gmail.com",
  "age"=>"30",
  "pref"=>"chiba",
  "mail"=>" kazumi@gmail.com"},
 {"name"=>"ichirou", "domain"=>"yahoo.co.jp", "age"=>"18", "pref"=>"tokyo"},
 {"name"=>" yuusuke", "domain"=>"hotmail.com", "age"=>"25", "pref"=>"chiba"},
 {"name"=>" satoshi",
  "domain"=>"gmail.com",
  "age"=>"45",
  "pref"=>"kanagawa",
  "mail"=>" satoshi@gmail.com"},
 {"name"=>"jirou ", "domain"=>"hotmail.com", "age"=>"9", "pref"=>"tokyo"}]
=end

arr5 = arr4.group_by{|person| person['pref']}
pp arr5

=begin
{"chiba"=>
  [{"name"=>" kazumi",
    "domain"=>"gmail.com",
    "age"=>"30",
    "pref"=>"chiba",
    "mail"=>" kazumi@gmail.com"},
   {"name"=>" yuusuke",
    "domain"=>"hotmail.com",
    "age"=>"25",
    "pref"=>"chiba"}],
 "tokyo"=>
  [{"name"=>"ichirou", "domain"=>"yahoo.co.jp", "age"=>"18", "pref"=>"tokyo"},
   {"name"=>"jirou ", "domain"=>"hotmail.com", "age"=>"9", "pref"=>"tokyo"}],
 "kanagawa"=>
  [{"name"=>" satoshi",
    "domain"=>"gmail.com",
    "age"=>"45",
    "pref"=>"kanagawa",
    "mail"=>" satoshi@gmail.com"}]}
=end

arr6 = [
    {'class' => 'A', 'type'=>'2' , 'pref' => 'chiba'},
    {'class' => 'A', 'type'=>'3' , 'pref' => 'tokyo'},
    {'class' => 'A', 'type'=>'2' , 'pref' => 'chiba'},
    {'class' => 'B', 'type'=>'1' , 'pref' => 'tokyo'},
];

arr7 = arr6.group_by{|person| person['class'] + '_'+ person['type']}
pp arr7

=begin
{"A_2"=>
  [{"class"=>"A", "type"=>"2", "pref"=>"chiba"},
   {"class"=>"A", "type"=>"2", "pref"=>"chiba"}],
 "A_3"=>[{"class"=>"A", "type"=>"3", "pref"=>"tokyo"}],
 "B_1"=>[{"class"=>"B", "type"=>"1", "pref"=>"tokyo"}]}
=end