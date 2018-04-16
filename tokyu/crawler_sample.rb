#!/usr/bin/ruby

# About nokogiri

require 'open-uri'
require 'nokogiri'

#doc = Nokogiri.HTML(open("http://nokogiri.org/"))
doc = Nokogiri.HTML(open("http://www.homes.co.jp/"))

# ページに含まれるリンクを出力する
doc.css('a').each do |element|
  puts element[:href]
end
# =>
# http://www.homes.co.jp/
# http://www.homes.co.jp/contents/no1/
# http://www.homes.co.jp/contents/abouthomes/
# http://www.homes.co.jp/contents/sitemap/
# http://www.homes.co.jp/callcenter/
# ...


# h2のテキストを出力する
doc2 = Nokogiri.HTML(open("http://www.homes.co.jp/"))
doc.xpath('//h2').each do |e|
  puts e.text
end
# =>
# 住まいを探す
# 不動産のカテゴリ一覧
# 住まい探しをはじめる前に
# 住まいが決まったら
# 住まいをキレイに、快適に
# 今と未来のオーナーの方へ
# 不動産会社の方へ
# 住宅研究、データベース
# HOME'Sとつながろう
# Pick up!
