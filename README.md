# Introduction
Ce projet a été réalisé par le groupe BA constitué de Camille Caulier et de Philippine de Suraÿ dans le cadre du cours LINFO1104. Le projet intitulé Twit-oz a pour objectif de réaliser un code en Oz permettant la prédiction de mots sur base des tweets de Donald Trump et en utilisant le modèle du N-gramme. Ici, nous nous sommes limités à 1-gramme pour limiter l'usage de la mémoire et obtenir un code plus rapide.

Vous trouverez dans ce README la structure détaillée des fichiers du travail, ainsi que la marche à suivre afin de compiler le code depuis Windows.

# Structure
## main.oz


## Reader.oz
La fonction Scan retourne la Nième ligne d'un fichier ou none si elle n'existe pas.

La procédure File_reading réparti équitablement les 208 fichiers dans 4 groupes (Port) pour permettre une lecture en parallèle des tweets de Donald Trump.

## Algo.oz
Le fichier Algo.oz contient les parties du programme à propos du parsing, de la sauvegarde et du N-gramme. 

La procédure UpdateWord permet d'initialiser un mot et son dictionnaire associé dans le dictionnaire si ils n'y sont pas encore et d'augmenter le compte du mot suivant ou de l'initialiser si c'est la première fois que la suite de ces deux mots est croisée.

La fonction ReachMostProb renvoie le mot suivant le plus probable d'une certaine suite de mots. Si le dernier mot de cette suite n'est pas apparu dans les tweets de Donald Trump analysés, et ne se retrouve donc pas dans le dictionnaire rassemblant tous les mots apparus, la fonction renvoie un message d'erreur.

La procédure Parse prend un tweet de Donald Trump et le sépare en fonction des mots contenus afin de rentrer chaque mot et son suivant dans le dictionnaire via la procédure UpdateWord décrite ci-dessus. Les ponctuations sont rejetées, sauf "-", "/" et "#".

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
