-- TP 2_04
-- Nom: Ludmann , Prenom: Dorian

-- +------------------+--
-- * Question 1 :     --
-- +------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  La liste des objets vendus par ght1ordi au mois de février 2023

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +----------+----------------------+
-- | pseudout | nomob                |
-- +----------+----------------------+
-- | etc...
-- = Reponse question 1.
select pseudout, nomob
from UTILISATEUR NATURAL JOIN OBJET NATURAL JOIN VENTE NATURAL JOIN STATUT
where pseudout ="ght1ordi" and MONTH(finVe) = 02 and YEAR(finVe) = 2023 and nomSt = "Validée";


-- +------------------+--
-- * Question 2 :     --
-- +------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  La liste des utilisateurs qui ont enchérit sur un objet qu’ils ont eux même mis en vente

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +-----------+
-- | pseudout  |
-- +-----------+
-- | etc...
-- = Reponse question 2.
select pseudout
from UTILISATEUR NATURAL JOIN OBJET NATURAL JOIN VENTE NATURAL JOIN ENCHERIR
where ENCHERIR.idUt = OBJET.idUt;

-- +------------------+--
-- * Question 3 :     --
-- +------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  La liste des utilisateurs qui ont mis en vente des objets mais uniquement des meubles

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +-------------+
-- | pseudout    |
-- +-------------+
-- | etc...
-- = Reponse question 3.
select DISTINCT pseudout
from UTILISATEUR NATURAL JOIN OBJET NATURAL JOIN CATEGORIE NATURAL JOIN VENTE
where nomcat = 'Meuble' and idUt not in(select idUt
                                        from UTILISATEUR NATURAL JOIN OBJET NATURAL JOIN CATEGORIE NATURAL JOIN VENTE
                                        where nomcat != 'Meuble');

-- +------------------+--
-- * Question 4 :     --
-- +------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  La liste des objets qui ont généré plus de 15 enchères en 2022

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +------+----------------------+
-- | idob | nomob                |
-- +------+----------------------+
-- | etc...
-- = Reponse question 4.

select idob, nomOb
from OBJET
where idOb in (select idob
               FROM ENCHERIR NATURAL JOIN VENTE
               WHERE YEAR(finVe) = 2022
               group by idve
               having count(finVe) >= 15);
order by idob asc;

-- +------------------+--
-- * Question 5 :     --
-- +------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  Ici NE CREEZ PAS la vue PRIXVENTE mais indiquer simplement la requête qui lui est associée. C'est à dire la requête permettant d'obtenir pour chaque vente validée, l'identifiant de la vente l'identiant de l'acheteur et le prix de la vente.

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +------+------------+----------+
-- | idve | idacheteur | montant  |
-- +------+------------+----------+
-- | etc...
-- = Reponse question 5.

select distinct idve, idUt idacheteur, montant
from ENCHERIR NATURAL JOIN VENTE v0 natural join STATUT
where nomSt = "Validée" and montant >= ALL(select montant
                                           FROM VENTE v1 natural join ENCHERIR
                                           where v0.idob = v1.idob);

-- +------------------+--
-- * Question 6 :     --
-- +------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  Le chiffre d’affaire par mois de la plateforme (en utilisant la vue PRIXVENTE)

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +------+-------+-----------+
-- | mois | annee | ca        |
-- +------+-------+-----------+
-- | etc...
-- = Reponse question 6.
create or replace view PRIXVENTE as
select distinct idve, idUt idacheteur, max(montant) montant
from VENTE NATURAL JOIN STATUT NATURAL JOIN ENCHERIR
where nomSt = "Validée"
group by idve;

select MONTH(finVe) mois, YEAR(finVe) annee, sum(montant) CA
from PRIXVENTE NATURAL JOIN VENTE
group by mois, annee
order by annee, mois;

-- +------------------+--
-- * Question 7 :     --
-- +------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  Les informations du ou des utilisateurs qui ont mis le plus d’objets en vente

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +------+----------+------+
-- | idut | pseudout | nbob |
-- +------+----------+------+
-- | etc...
-- = Reponse question 7.
select idUt, pseudoUt, count(IFNULL(idVe,0)) nbob
from UTILISATEUR NATURAL LEFT JOIN OBJET NATURAL LEFT JOIN VENTE
group by idUt
having nbob >= ALL (select count(IFNULL(idVe,0)) nbob
                    from UTILISATEUR NATURAL LEFT JOIN OBJET NATURAL LEFT JOIN VENTE
                    group by idUt);


-- +------------------+--
-- * Question 8 :     --
-- +------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  le camembert

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +-------+-------------------+-----------+
-- | idcat | nomcat            | nb_objets |
-- +-------+-------------------+-----------+
-- | etc...
-- = Reponse question 8.
select idcat, nomcat, count(idOb) nb_objets
from OBJET NATURAL JOIN CATEGORIE NATURAL JOIN VENTE NATURAL JOIN STATUT
where YEAR(finVe) = 2022 and idSt = 4
group by idcat;



-- +------------------+--
-- * Question 9 :     --
-- +------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  Le top des vendeurs

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +------+-------------+----------+
-- | idut | pseudout    | total    |
-- +------+-------------+----------+
-- | etc...
-- = Reponse question 9.

select distinct idUt, pseudout, max(IFNULL(montant,0)) total
from UTILISATEUR NATURAL LEFT JOIN ENCHERIR NATURAL LEFT JOIN VENTE NATURAL LEFT JOIN STATUT
where nomSt = "Validée"  and MONTH(FinVe) = 01 and YEAR(FinVe) = 2023
group by idUt
order by total DESC
limit 10;

-- Recherche de l'objet volé
-- • L’objet a été mis en vente en début de mois (avant le 15).
-- • Il a été mis en vente à une somme inférieure à 500€.
-- • Il a été vendu à plus de 10 fois le prix de vente initial.
--Vue qui permet d'obtenir toute les ventes qui ont eu pour prix final une offre de plus de 5000€
select DISTINCT idUt, pseudoUt, emailUT, idOb, nomOb
from UTILISATEUR NATURAL JOIN OBJET NATURAL JOIN VENTE
where DAY(debutVe) < 15 and prixBase < 500 and idVe in (select idVe
                                                        from ENCHERIR NATURAL JOIN VENTE
                                                        where montant > prixBase*10)
order by idUt;

-- Inserts
insert into UTILISATEUR(idUt,pseudoUt,emailUT,mdpUt,activeUt,idRole) values
	(874520,'IUTO','iuto1@info.univ-orleans.fr','IUTO','O',2);

insert into OBJET(idOb,nomOb,descriptionOb,idCat,idUt) values
	(734514,'Canapé clic-clac','Très beau et ayant peu servi',1,847);

insert into VENTE(idVe,prixBase,prixMin,debutVe,finVe,idSt,idOb) values
	(378421543,40,80,STR_TO_DATE('23/3/2023:00:00:00','%d/%m/%Y:%h:%i:%s'),DATE_ADD(STR_TO_DATE('30/3/2023:23:59:59','%d/%m/%Y:%h:%i:%s'), INTERVAL 8 DAY),2,734514);


./extraire_donnees.py --login ludmann --serveur servinfo-mariadb --bd DBludmann --requete "select distinct idUt, pseudout, max(IFNULL(montant,0)) total
from UTILISATEUR NATURAL LEFT JOIN ENCHERIR NATURAL LEFT JOIN VENTE NATURAL LEFT JOIN STATUT
where nomSt = "Validée"  and MONTH(FinVe) = 01 and YEAR(FinVe) = 2023
group by idUt
order by total DESC
limit 10;" --fic_res le_resultat2.csv