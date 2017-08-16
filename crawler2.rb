# URLにアクセスするためのライブラリの読み込み
require 'open-uri'
# Nokogiriライブラリの読み込み
require 'nokogiri'
# 文字をShift_JISに変更するためのライブラリの読み込み
require 'kconv'
# csvに書き出すためのライブラリの読み込み
require 'csv'

count = 0

best_venture_100_list = []

# スクレイピング先のURL
url = "http://best100.v-tsushin.jp/"

charset = nil
html = open(url) do |f|
  charset = f.charset # 文字種別を取得
  f.read # htmlを読み込んで変数htmlに渡す
end

puts html
if html =~ /best1001/
    puts "exist"
end

# htmlをパース(解析)してオブジェクトを生成
doc = Nokogiri::HTML.parse(html.toutf8, nil, 'utf-8')
# id=companyListのulを取得
companies = doc.css("ul#companyList")
# id=companyListのul以下のliを配列で取得
company_list = companies.css("li")
# 配列内のliを一つ一つeachでfetchする
company_list.each do |company|
  # dataを保存するArrayを作成
  data = []
  count += 1
  # liの子要素であるimgのtitle情報を取得
  name = company.css("img")[0][:title]
  # liの子要素であるaのhrehパラメータを取得
  url = company.css("a")[0][:href]
  # liの子要素であるimgのsrcパラメータを取得
  logo = company.css("img")[0][:src]

  # 各要素を確認
  p count, name, url, logo

  # data配列に取得した情報を格納
  data.push(count)
  data.push(name.tosjis)
  data.push(url.tosjis)
  data.push(logo.tosjis)

  # best_venture_100_list配列に、data配列を格納し、二重配列を作成(csvfileへの変換のため)
  best_venture_100_list.push(data)
end
# 二重配列となったbest_venture_100_listをターミナルで表示

raise
# CSVにエクスポート
CSV.open("best_venture_100_list.csv", "wb") do |csv|
  best_venture_100_list.each do |r|
    csv << r
  end
end
