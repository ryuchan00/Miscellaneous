#!/usr/bin/ruby
# coding: utf-8

require 'uri'
require 'open-uri'
require 'nokogiri'

# url:検索url
def crawl(url)
  puts "#{url}:スタート"
  begin
    doc = Nokogiri.HTML(open(url))
    charset = ""
    html = open(url) do |f|
      charset = f.charset
      f.read
    end

    # todo:"iso-8859-1"をエンコードしようとするとエラー発生
    reg = @search.encode(charset)
    if html =~ /#{reg}/
      puts "#{url}:存在しました"
      root = [url]
      while @links.assoc(url)[1] != ""
        root.unshift(@links.assoc(url)[1])
        url = @links.assoc(url)[1]
      end
      puts "#{@search}までの経路"
      puts "スタート"
      root.each do |u|
        puts u
      end
      puts "エンド"
      return true
    end
    puts "#{url}:存在しませんでした"

    # ページに含まれるリンクを出力する
    doc.css('a').each do |element|
      link = element[:href].to_s
      unless link =~ /^http/
        link = URI.join(url, link).to_s
      end

      # javascript:void(0)が混じることがあるので、urlの形式確認
      if http?(link)
        # getパラメーターを削除
        link = regLink(link)
        unless @links.assoc(link)
          @links.push([link, url])
        end
      end
    end

  rescue => e
    puts "#{url}:エラーが発生"
    puts e.class
    puts e.message
  end

  @i += 1
  if @links.size <= @i
    p @links
    puts "#{@search}は存在しませんでした"
    return false
  end
  crawl(@links[@i][0])
end

# URIの構文チェック
def http?(str)
  begin
    uri = URI.parse(str)
  rescue URI::InvalidURIError
    return false
  end
  return true
end

# getパラメーターや末尾のスラッシュ削除
def regLink(url)
  if regUrl = url.match(%r{(http://.*|https://.*)([#\?].*|\/$)})
    url = regUrl[1]
  end
  return url
end

@links = [] # [[探索するurl, リンク元のurl], [探索するurl, リンク元のurl]...]
@i = 0 # @linksのカウント
@search = ARGV[1]

link = regLink(ARGV[0].to_s)
@links.push([link, ""])
crawl(@links[@i][0])
