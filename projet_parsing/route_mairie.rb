require 'rubygems'
require 'nokogiri'
require 'open-uri'

### Important d'être connecter à internet pour que tout marhce :)

#on recupère l'adresse mail de la mairie grace à son site sur l'annuaire
#j'ai un peu bidouillé le selecteur css pour que ça tombe sur la bonne ligne :)
def get_the_email_of_a_townhal_from_its_webpage(url_page)
  page = Nokogiri::HTML(open(url_page))
  mail = page.css("td.style27 p.Style22 font")[6]
  mail.text
  #/html/body/table/tbody/tr[3]/td/table/tbody/tr[1]/td[1]/table[4]/tbody/tr[2]/td/table/tbody/tr[4]/td[2]/p/font
end


def get_all_the_urls_of_val_doise_townhalls()
  page_annuaire = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
  pages_mairies = page_annuaire.css("table.Style20 a.lientxt")
  pages_mairies.each{|mairie|  mairie["href"]= right_url(mairie["href"])}
  #pages_mairies.each{|mairie| puts mairie.text}
  pages_mairies


end


# l'url recupéré est sous cette forme "./95/villers-en-arthies.html"
#on la formate dans cette fonction pourqu'elle est la bonne forme "http://annuaire-des-mairies.com/95/villers-en-arthies.html"
#split('') pour la transformer en array; drop(1) enlève le premier element; *'' regoupe le tout et tranforme en chaine de carractère
def right_url(url)
  url ='http://annuaire-des-mairies.com' + url.split('').drop(1)*''
end

#retourne un array de hash avec le nom de la mairie et son adresse mail
def perform()
  res = []
  get_all_the_urls_of_val_doise_townhalls().each do |mairie_url|
    nom = mairie_url.text
    email = get_the_email_of_a_townhal_from_its_webpage(mairie_url["href"])
    #puts "nom : #{nom}  email: #{email}"
    res << {:name =>nom , :email=>email }
  end
  res
end

#puts get_the_email_of_a_townhal_from_its_webpage "http://annuaire-des-mairies.com/95/vaureal.html"
#puts get_the_email_of_a_townhal_from_its_webpage "http://annuaire-des-mairies.com/95/frepillon.html"
#get_all_the_urls_of_val_doise_townhalls()

#puts perform prend un peu de temps :)
puts perform()
