require 'rubygems'
require 'nokogiri'
require 'open-uri'

### Important d'être connecter à internet pour que tout marhce :)

def parse_criptomonies()
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


#boucle infinie qui relance la fonction tout les "t second"
#pour les besoin de l'exo on met t = 15 s
#on pourrait le mettre à 3600s = 1heure comme dans l'énoncé
#appuyer sur ctrl +c pour arreter la boucle
t = 15
while true
  parse_criptomonies().each do |crypto|
    puts "nom : #{crypto[:name]},   cours = #{crypto[:price]}"  
  end
  #sleep arrête le programme pendant t second
  sleep(t)
  puts " =============MISE A JOUR====================="
  puts " ============================================="
  sleep(2)
end
