require 'rubygems'
require 'nokogiri'
require 'open-uri'

PAGE_URL = "https://en.wikipedia.org/wiki/HTML"

page = Nokogiri::HTML(open(PAGE_URL))

# news_links = page.css("div#references a")
# news_links.each{ |link| puts " <#{link.text} > is about link #{link['href']} "}
link = page.css('Filename extension')
puts link
puts link.text +"is liked :"+ link['href']
