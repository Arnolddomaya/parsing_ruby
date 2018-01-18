require 'rubygems'
require 'nokogiri'
require 'open-uri'


def trader()
  res = []
  page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
  #on recupère le tableau qui contient tout les cryptomonaies dans un tableau
  cryptomonaies = page.css("#currencies-all > tbody:nth-child(2) tr")
  #pour tout les cryptomonaie du tableau on recupère le nom et le cours : price
  cryptomonaies.each do |cryptomonaie|
    nom = cryptomonaie.css("a.currency-name-container").text
    price = cryptomonaie.css("a.price").text
    #puts "nom = #{nom}, price = #{price}"
    res << {:name =>nom , :price=>price }
  end
  res
end

#currencies-all > tbody:nth-child(2)
puts trader()
