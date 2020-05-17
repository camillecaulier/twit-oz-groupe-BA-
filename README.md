# Introduction
Ce projet a été réalisé par le groupe BA constitué de Camille Caulier et de Philippine de Suraÿ dans le cadre du cours LINFO1104. Le projet intitulé Twit'oz a pour objectif de réaliser un code en Oz permettant la prédiction de mots sur base des tweets de Donald Trump et en utilisant le modèle du N-gramme. Ici, nous nous sommes limités à 1-gramme pour limiter l'usage de la mémoire et obtenir un code plus rapide.

Vous trouverez dans ce README la structure détaillée des fichiers du travail, ainsi que la marche à suivre afin de compiler le code depuis Windows.

# Structure
## main.oz
Dans le fichier main.oz, 4 streams sont créés via la fonction CreatePortParse. Ceux-ci serviront de lien entre la lecture en parallèle (par l'usage de 4 threads de lecture et de la procédure File_reading de Reader.oz) et le parsing via la procédure Parse de Algo.oz (4 threads de parsing) qui permet de rentrer tous les mots dans le dictionnaire et de les sauvegarder ainsi.

Concernant l'interface graphique et GUI, la fenêtre contient deux zones de textes, celle du dessus pour l'affichage du résultat, et celle du dessous qui affiche un message d'erreur en cas de soucis ou les recommendations. Elle contient aussi 3 boutons: 
- Automatic fill : rempli le texte directement dans la première zone ou affiche un message d'erreur. Il est utilisable plusieurs fois de suite, et prend donc en compte toujours le dernier mot inscrit.

- recommendation : rempli la phrase "Trump's favorite word after ..... is: ....." dans la deuxième zone de texte ou affiche un message d'erreur.

- exit : permet de quitter l'interface. La croix dans le coin suppérieur droit le permet aussi.

L'utilisateur peut donc écrire son texte dans le première zone et cliquer sur le bouton de son choix en fonction de son souhait. Le programme s'ajuste aux ponctuations et prend le mot en les supprimant pour définir le prochain.

## Reader.oz
Le fichier Reader.oz permet de lire les tweets contenus dans le dossier tweets. La procédure File_reading réparti équitablement les 208 fichiers dans 4 streams (Port) et va séparer les différents tweets entre eux pour permettre une lecture en parallèle des tweets de Donald Trump.

## Algo.oz
Le fichier Algo.oz contient les parties du programme à propos du parsing, de la sauvegarde et du N-gramme. 

La procédure UpdateWord permet d'initialiser un mot et son dictionnaire associé dans le dictionnaire si ils n'y sont pas encore et d'augmenter le compte du mot suivant ou de l'initialiser si c'est la première fois que la suite de ces deux mots est croisée.

La fonction ReachMostProb renvoie le mot suivant le plus probable d'une certaine suite de mots. Si le dernier mot de cette suite n'est pas apparu dans les tweets de Donald Trump analysés, et ne se retrouve donc pas dans le dictionnaire rassemblant tous les mots apparus, la fonction renvoie un message d'erreur.

La procédure Parse prend un tweet de Donald Trump et le sépare en fonction des mots contenus afin de sauvegarder chaque mot et son suivant dans le dictionnaire via la procédure UpdateWord décrite ci-dessus. Les ponctuations sont rejetées, sauf "-", "/" et "#".

## Makefile
Notre Makefile contient deux commandes pour lancer le programme:
```
usern@me:~yourpath$  make run
```
et supprimer les exécutables créés:
```
usern@me:~yourpath$  make clean
```

## tweets
Ce dossier contient tous les fichiers des tweets utilisés pour remplir le dictionnaire servant à la prédiction des mots.

# Compilation
Afin de compiler le programme, utilisez la commande ci-dessous qui créera un exécutable main.oza, Reader.ozf et Algo.ozf (s'ils ne sont pas encore créés) et lancera le programme:
```
usern@me:~yourpath$  make run
```

Pour supprimer les exécutables, entrez cette commande-ci:
```
usern@me:~yourpath$  make clean
```
