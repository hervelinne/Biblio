class Adherent 
    attr_accessor :nom, :prenom, :id, :emprunt, :doc
    @@num = 0
    def initialize(nom, prenom)
        @@num += 1
        @id= @@num
        @nom=nom.upcase
        @prenom = prenom.capitalize 
        @doc = []
        @emprunt = {"materiel" => ' ' , "documents" => @doc }
    end 
    def emprtMat(materiel)
        if @emprunt["materiel"] == " "
            @emprunt["materiel"] = materiel.matInfo
        elsif
            puts "nombre maximum de materiel emprunté atteint !!! "
        end
    end
    def emprtDoc(doc)
        if (@emprunt["documents"].length < 5)
            @doc.push(doc)
        elsif
            puts "nombre maximum de documents empruntés atteint !!! "
        end
    end
    def rendreMat(materiel)
        @emprunt.delete("materiel")
    end 
    def rendreDoc(doc)
        @emprunt["documents"].delete(doc.docInfo)
    end
    def afficher()
        puts "ID : " + @id.to_s + " , Nom : "+@prenom+" "+@nom + " , materiel emprunté : " + @emprunt["materiel"] + " , Documents empruntés : " + @emprunt["documents"].inspect
    end
    def toString()
        if @emprunt.has_key?("materiel")
            a =   "ID : " + @id.to_s + " , Nom : "+@prenom+" "+@nom + " , materiel emprunté : " + @emprunt["materiel"] + " , Documents empruntés : " + @emprunt["documents"].inspect
        elsif 
            a =   "ID : " + @id.to_s + " , Nom : "+@prenom+" "+@nom + ", Documents empruntés : " + @emprunt["documents"].inspect
        end
        return a 
    end    
end 


class Materiel 
    attr_accessor :id, :marque, :os, :statut
    @@num = 0
    def initialize(marque, os)
        @@num += 1
        @id = @@num
        @marque = marque
        @os = os
        @statut = "Disponible"
    end
    def afficher()
        puts "Marque : " + @marque + " / OS : " + @os + " - Statut : " + @statut
    end 
    def toString()
        return "ID : "+ @id +" - Marque : " + @marque + " / OS : " + @os + " - Statut : " + @statut
    end
    def matInfo
        return "Marque : " + @marque + " / OS : " + @os
    end
end 

class Document
    #types = ["livre", "revue", "dictionnaire", "BD"]
    attr_accessor :type, :isbn, :titre, :auteur, :statut
    def initialize (type, titre, auteur, isbn)
        @type = type
        @titre = titre
        @auteur = [auteur]
        @isbn = isbn
        @statut = "Disponible"
    end
    def afficher()
        puts  " Titre : " + @titre + " / Auteur(s) : " + @auteur.join(" - ") + " / Type : " + @type  + "  / ISBN : " + @isbn.to_s + " - Statut : " + @statut
    end
    def toString()
        return " Titre : " + @titre  + " / Auteur(s) : " + @auteur.join(" - ") + " / Type : " + @type  + "  / ISBN : " + @isbn.to_s + " - Statut : " + @statut
    end
    def docInfo
        return " Titre : " + @titre  + " / Auteur(s) : " + @auteur.join(" - ") + " / Type : " + @type  + "  / ISBN : " + @isbn.to_s
    end
    def setAuteur(auteur)
        @auteur.push(auteur)
    end
end 

class Auteur 
    attr_accessor :id, :nom
    @@num = 0
    def initialize(nom)
        @@num += 1
        @id = @@num
        @nom = nom
    end
    def afficher()
        puts "Auteur : "+ @nom  + " / ID : " + @id.to_s
    end
    def toString()
        return "Auteur : "+ @nom  + " / ID : " + @id.to_s
    end
    def id()
        return @id
    end 
end

class Biblio
    attr_accessor :documents, :adherents, :materiels, :emprunts, :auteurs
    def initialize ()
        @documents = Hash.new
        @adherents = Hash.new
        @materiels = Hash.new
        @auteurs = Hash.new
        @empruntsMat = Hash.new
        @empruntsDoc = Hash.new
    end
    def ajtDoc(doc)
        @documents[doc.isbn] = doc
    end
    def ajtAdh(adh)
        @adherents[adh.id] = adh
    end
    def ajtMat(mat)
        @materiels[mat.id] = mat
    end 
    def emprtMat(idMat, id)
        if  @materiels[idMat].statut == 'Disponible'
            @materiels[idMat].statut = 'Indisponible'
            @adherents[id].emprtMat(@materiels[idMat])
        elsif
            puts " Le materiel que vous souhaitez emprunter est indisponible "
        end 
    end
    def emprtDoc(isbnDoc, id)
        if  @documents[isbnDoc].statut == 'Disponible'
            @documents[isbnDoc].statut = 'Indisponible'
            @adherents[id].emprtDoc(@documents[isbnDoc])
        elsif
            puts " Le document que vous souhaitez emprunter est indisponible "
        end 
    end
    def rendreMat(idMat, id)
        if  @materiels[idMat].statut == 'Indisponible'
            @materiels[idMat].statut = 'Disponible'
            @adherents[id].rendreMat(@materiels[idMat])
        elsif
            puts " Le materiel que vous souhaitez rendre a déjà êté rendu "
        end 
    end
    def rendreDoc(isbnDoc, id)
        if  @documents[isbnDoc].statut == 'Indisponible'
            @documents[isbnDoc].statut = 'Disponible'
            @adherents[id].rendreDoc(@documents[isbnDoc])
        elsif
            puts " Le document que vous souhaitez rendre a déjà êté rendu "
        end 
    end
    def ajtAutr(a) 
        @auteurs[a.id] = a
    end 
    def ajtAuthLivre(a, titre)
        @documents.keys.each{ |c| 
            if @documents[c].titre == titre
                @documents[c].auteur.push(a.nom)
            end
        }
    end
    def listAdh()
        puts "Liste des adhérents : "
        @adherents.values.each{ |a| puts a.toString }
    end
    def listDoc()
        puts "Liste des documents : "
        @documents.values.each{ |d| puts d.toString }
    end
    def listAutr()
        puts "Liste des auteurs : "
        @auteurs.values.each{ |a| puts a.toString }
    end
    def listMat()
        puts "Collection d'ordinateurs portables : "
        @materiels.values.each{ |m| puts m.toString }
    end
    def searchAdhByID(id)
        cles = false
        for k in @adherents.keys
            if k == id
                puts @adherents[id].toString
                cles = true
                break
            end
        end
        if !cles
            puts "\nAucun(e) adhérent(e) ne correspond à cet ID !"
        end
    end
    def searchDocByISBN(isbn)
        cles = false
        for k in @documents.keys
            if k == isbn
                return @documents[isbn].toString
                cles = true
                break
            end
        end
        if !cles
            puts "\nAucun document ne correspond à cet ISBN !"
        end
    end
    def searchMatByID(id)
        cles = false
        for k in @materiels.keys
            if k == id
                return @materiels[id].toString
                cles = true
                break
            end
        end
        if !cles
            puts "\nAucun materiel ne correspond à cet ID !"
        end
    end
    def searchAthByID(id)
        cles = false
        for k in @auteurs.keys
            if k == id
                puts @auteurs[id].toString
                cles = true
                break
            end
        end
        if !cles
            puts "\nAucun materiel ne correspond à cet ID !"
        end
    end
    def searchByWord(word)
        @documents.keys.each{ |k|
            a = @documents[k].titre
            a = a.tr('.,"_:-','').downcase.split(' ')
            print a
            if a.include?(word)
                puts @documents[k].toString
            end
        }
    end
    def supprAdh(id)
        @adherents.delete(id)
    end
    def supprMat(id)
        @materiels.delete(id)
    end
    def supprDoc(isbn)
        @documents.delete(isbn)
    end
    def adhCSV()
        CSV.open('adherants.csv', "w") do |csv|
            csv << ["ID", "Nom", "Prenom", "Objets empruntés", "documents Empruntés"]
            @adherents.values.each { |adh|
              csv << [adh.id, adh.nom, adh.prenom, adh.emprunt.inspect, adh.doc.inspect]
            }
        end
    end
    def docCSV()
        CSV.open('documents.csv', "w") do |csv|
            csv << ["ISBN", "Titre", "Auteur(s)", "Type", "Statut"]
            @documents.values.each { |doc|
              csv << [doc.isbn, doc.titre, doc.auteur, doc.type, doc.statut]
            }
        end
    end
    def matCSV()
        CSV.open('materiels.csv', "w") do |csv|
            csv << ["ID", "Marque", "OS", "Statut"]
            @materiels.values.each { |matt|
              csv << [mat.id, mat.marque, mat.os, mat.statut ]
            }
        end
    end
    def autrCSV()
        CSV.open('auteurs.csv', "w") do |csv|
            csv << ["ID", "Nom"]
            @auteurs.values.each { |autr|
              csv << [autr.id, autr.nom]
            }
        end
    end
end


