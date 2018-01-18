require 'rubygems'
require 'nokogiri'
require 'open-uri'

#exo non terminé; pistes de travail

#on va lancer le parsing sur ce site http://mon-incubateur.com/site_incubateur/incubateurs/1/#
def route_incubators()
  res = []
  page = Nokogiri::HTML(open("http://mon-incubateur.com/site_incubateur/incubateurs/1/"))
  listes_incubateurs = page.xpath('//span')
  listes_incubateurs.each do |incubator|
    url_page= incubator.xpath("a['href']")
    #url_page= find_website(incubator.xpath("a['href']"))
    name = incubator.xpath("a").text
    res << {:name=>name, :website=>url_page}
  end
  puts res
end

#css("div#incubators_list ")
#//*[@id="incubators_list"]//tbody

def find_website(url)
  page = Nokogiri::HTML(open(url))
  website = page.xpath("/html/body/div[3]/div[2]/div/p[2]/a")
  website = website['href']
  website
end

route_incubators()
