require_relative 'bibliotheque.rb'
require 'csv'
b = Biblio.new
fin = false 
puts "\n\n Bienvenu dans Biblio : \n\n Ce programme vous permet d'effectuer les actions suivantes :\n\n"
while !fin 
    puts "\n\n0 - Terminer le programme : \n\n"
    puts "================================="
    puts " 1 - Creer un adherant :  "
    puts " 2 - Creer un document :  "
    puts " 3 - Creer un ordinateur portable :  \n\n"

    puts " 4 - Recherche d'un adherant par ID : "
    puts " 5 - Recherche d'un document par ISBN : "
    puts " 6 - Recherche d'un materiel par ID : \n\n"

    puts " 7 - Voir la liste des adherants :"
    puts " 8 - Voir la liste des documents :"
    puts " 9 - Voir la collection d'ordinateurs : \n\n"

    puts " 10 - Ajouter une personne aux auteurs d'un livre :"
    puts " 11 - Rechercher un auteur par ID :"
    puts " 12 - Voir l'ensemble des IDs des auteurs : \n\n"

    puts " 13 - Voir l'ensemble des ID du materiel : \n\n"

    puts " 14 - Supprimer un adherant :"
    puts " 15 - Supprimer un materiel :"
    puts " 16 - Supprimer un document :\n\n"

    puts " 17 - Emprunter un ordinateur :"
    puts " 18 - Emprunter un livre :\n\n"

    puts " 19 - Rendre un ordinateur :"
    puts " 20 - Rendre un document :\n\n"

    puts " 21 - Enregistre la bibliothèque dans des fichiers CSV :\n\n"

    puts " 22 - Rechercher un document via un mot precis : "

    puts "\n Veuillez saisir le numero correspondant a votre choix :"
    print " -->  "
    i = gets.chomp.to_i
    case i
        when 0
            puts "Au revoir ! \\^w^/"
            fin = true
        when 1 
            puts "Veuillez saisir le nom de l'adhérent(e) : " 
            nom = gets.chomp
            puts "Veuillez saisir le prenom de l'adhérent(e) : "
            prenom = gets.chomp
            a = Adherent.new(nom,prenom)
            b.ajtAdh(a)
        
        when 2 
            puts "Les types de documents sont les suivant : " 
            puts "1 - Livre " 
            puts "2 - Revue " 
            puts "3 - Dictionnaire " 
            puts "4 - BD " 
            puts "Pour ajouter un document veuillez saisir le numéro correspondant au type de ce document :"
            print "--> "
            t  = gets.chomp
            if ( t == '1')
                type = 'Livre'
            elsif (t == '2')
                type = 'Revue'
            elsif (t == '3')
                type = 'Dictionnaire'
            elsif (t == '4')
                type = 'BD'
            end
            # faire un raise si else 
            puts "Veuillez saisir le nom du document : " 
            titre = gets.chomp
            puts "Veuillez saisir l'auteur du document : " 
            auteur = gets.chomp
            a = Auteur.new(auteur)
            puts "Veuillez saisir l'isbn du document : " 
            isbn = gets.chomp.to_i
            d = Document.new(type, titre, auteur, isbn)
            b.ajtDoc(d)
            b.ajtAutr(a)
        when 3 
            puts "Veuillez saisir la marque de l'ordinateur portable : " 
            marque = gets.chomp
            puts "Veuillez saisir l'OS de l'ordinateur : "
            puts "1 - MacOS "
            puts "2 - Linux "
            puts "3 - Windows" 
            print "--> "
            s  = gets.chomp
            if ( s == '1')
                os = 'MacOS'
            elsif (s == '2')
                os = 'Linux'
            elsif (s == '3')
                os = 'Windows'
            end
            #faire raise ..
            m = Materiel.new(marque,os)
            b.ajtMat(m)
        when 4
            puts " Veuillez saisir l'ID de l'adherent(e) : "
            id = gets.chomp.to_i
            b.searchAdhByID(id)
        when 5 
            puts "Saisir l'ISBN du document : "
            isbn = gets.chomp.to_i
            puts b.searchDocByISBN(isbn)
        when 6
            puts "saisir l'ID du matériel : "
            id = gets.chomp.to_i
            puts b.searchMatByID(id)
        when 7
            b.listAdh
        when 8
            b.listDoc
        when 9
            b.listMat
        when 10
            puts "Quel est le titre du document dont vous souhaitez ajouter un auteur ? "
            titre = gets.chomp
            puts "Veuillez saisir le nom de l'auteur : "
            auteur = gets.chomp
            a = Auteur.new(auteur)
            b.ajtAutr(a)
            b.ajtAuthLivre(a, titre)
        when 11
            puts "Veuillez saisir l'id de l'auteur : "
            id = gets.chomp.to_i
            b.searchAthByID(id)
        when 12
            b.listAutr
        when 13
            b.listMat
        when 14
            puts "Veuillez saisir l'ID de l'adhérent à supprimer : "
            id = gets.chomp.to_i
            b.supprAdh(id)
        when 15
            puts "Veuillez saisir l'ID du matériel à supprimer : "
            id = gets.chomp.to_i			
            b.supprMat(id)	 
            
        when 16
            puts "Veuillez Saisir l'ISBN du document à supprimer : "
            isbn= gets.chomp.to_i
            b.supprDoc(id)
        when 17
            puts "Veuillez saisir l'ID de la personne souhaitant emprunter le materiel : "
            id = gets.chomp.to_i
            puts "Veuillez saisir l'ID du materiel à emprunter : "
            matid = gets.chomp.to_i
            b.emprtMat(matid, id)
        when 18
            puts "Veuillez saisir l'ID de la personne souhaitant emprunter le document : "
            id = gets.chomp.to_i
            puts "Veuillez saisir l'ISBN du document à emprunter :  "
            isbnDoc = gets.chomp.to_i
            b.emprtDoc(isbnDoc, id)
            
        when 19
            puts "Veuillez saisir l'ID de la personne souhaitant rendre le materiel : "
            id = gets.chomp.to_i
            puts "Veuillez saisir l'ID du materiel à rendre : "
            matid = gets.chomp.to_i
            b.rendreMat(matid, id)
        when 20
            puts "Veuillez saisir l'ID de la personne souhaitant rendre le document : "
            id = gets.chomp.to_i
            puts "Veuillez saisir l'ISBN du document à rendre :  "
            isbnDoc = gets.chomp.to_i
            b.rendreDoc(isbnDoc, id)
        when 21
            puts " Choississez quelle liste de biblio vous souhaitez exporter : "
            puts " 1 - Liste adherants :  "
            puts " 2 - Liste documents :  "
            puts " 3 - Liste materiels :  "
            puts " 4 - Liste auteurs :  \n\n"
            print "--> "
            l = gets.chomp.to_i
            case l
                when 1 
                    b.adhCSV
                when 2 
                    b.docCSV
                when 3
                    b.matCSV
                when 4 
                    b.autrCSV
                end
        when 22
            puts "Veuillez saisir votre mot : "
            print"-->  "
            mot = gets.chomp
            b.searchByWord(mot)

    end 
end
