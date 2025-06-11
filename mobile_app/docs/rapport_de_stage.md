# Rapport de Stage
## Développement d'une Application Mobile de Gestion de Point de Vente (POS)
### Stage effectué du 01/01/2024 au 31/03/2024

**Étudiant:** Ilyas BENALI  
**Formation:** Master en Informatique - Spécialité Développement Mobile  
**École:** École Supérieure d'Informatique et de Technologies Numériques  
**Entreprise:** TechSolutions SARL  
**Tuteur Entreprise:** M. Jean DUPONT, Directeur Technique  
**Tuteur École:** Mme. Marie LEFEBVRE, Professeur en Développement Mobile

## Dédicaces
À mes parents, pour leur soutien inconditionnel et leur confiance en moi tout au long de mon parcours académique.

À mes professeurs, qui m'ont transmis leur savoir et leur passion pour l'informatique.

À l'équipe de TechSolutions, pour m'avoir accueilli et guidé dans ce projet enrichissant.

## Remerciements
Je tiens à exprimer ma profonde gratitude à toutes les personnes qui ont contribué à la réussite de ce stage.

En premier lieu, je remercie M. Jean DUPONT, mon tuteur en entreprise, pour son encadrement, ses conseils avisés et sa disponibilité tout au long de ce stage. Son expertise et son professionnalisme ont été déterminants dans la réussite de ce projet.

Je remercie également l'équipe de développement de TechSolutions pour leur accueil chaleureux, leur disponibilité et leur esprit d'équipe. Leur expertise technique et leur soutien ont été précieux dans la réalisation de ce projet.

Un grand merci à Mme. Marie LEFEBVRE, mon tuteur académique, pour son soutien constant, ses orientations précieuses et son accompagnement tout au long de ce stage.

Enfin, je remercie ma famille et mes amis pour leur soutien moral et leur compréhension pendant cette période intense de travail.

## Table des Matières
1. [Introduction Générale](#introduction-générale)
2. [Chapitre 1: Contexte Général du Projet](#chapitre-1-contexte-général-du-projet)
   - 1.1. Introduction
   - 1.2. Présentation de l'organisme d'accueil
   - 1.3. Cadre du projet
   - 1.4. Analyse et spécification des besoins
   - 1.5. Gestion du projet
   - 1.6. Planification prévisionnelle
   - 1.7. Conclusion
3. [Chapitre 2: Analyse et Conception](#chapitre-2-analyse-et-conception)
   - 2.1. Introduction
   - 2.2. Méthodes et outils de modélisation
   - 2.3. Diagrammes de cas d'utilisation
   - 2.4. Étude des Diagrammes de séquences
   - 2.5. Diagramme de classe
   - 2.6. Conclusion
4. [Chapitre 3: Réalisation du Projet](#chapitre-3-réalisation-du-projet)
   - 3.1. Introduction
   - 3.2. Architecture MVC
   - 3.3. Outils, langage et Framework utilisés
   - 3.4. Présentation et description des interfaces
   - 3.5. Conclusion
5. [Conclusion Générale](#conclusion-générale)
6. [Annexes](#annexes)

## Table des Figures
- Figure 1.1: Organigramme de TechSolutions SARL
- Figure 1.2: Maquette de l'écran de connexion
- Figure 1.3: Maquette du tableau de bord administrateur
- Figure 2.1: Diagramme de cas d'utilisation
- Figure 2.2: Diagramme de séquence - Processus de vente
- Figure 2.3: Diagramme de classe
- Figure 3.1: Architecture MVC de l'application
- Figure 3.2: Interface de connexion
- Figure 3.3: Tableau de bord administrateur
- Figure 3.4: Interface vendeur
- Figure 3.5: Page des rapports

## Liste des Tableaux
- Tableau 1.1: Calendrier prévisionnel du projet
- Tableau 1.2: Matrice des besoins fonctionnels
- Tableau 1.3: Matrice des besoins non fonctionnels
- Tableau 2.1: Liste des acteurs et leurs rôles
- Tableau 2.2: Liste des cas d'utilisation
- Tableau 3.1: Technologies utilisées
- Tableau 3.2: Structure de la base de données

## Acronymes
- **API**: Application Programming Interface
- **MVC**: Model-View-Controller
- **POS**: Point Of Sale
- **PME**: Petite et Moyenne Entreprise
- **SQL**: Structured Query Language
- **UML**: Unified Modeling Language
- **UI**: User Interface
- **UX**: User Experience

## Introduction Générale
Dans un contexte où la digitalisation des commerces devient essentielle, TechSolutions SARL a identifié un besoin croissant pour des solutions mobiles de gestion de point de vente. Ce stage s'inscrit dans ce contexte, visant à développer une application mobile moderne et efficace pour répondre à ces besoins.

L'objectif principal de ce stage est de concevoir et développer une application mobile de gestion POS complète, permettant aux commerçants de gérer leurs ventes, stocks et rapports commerciaux de manière efficace et intuitive.

## Chapitre 1: Contexte Général du Projet

### 1.1. Introduction
Le projet de développement d'une application mobile de gestion POS s'inscrit dans la stratégie de digitalisation de TechSolutions. Cette application vise à moderniser et optimiser la gestion des points de vente pour les commerçants.

### 1.2. Présentation de l'organisme d'accueil
#### 1.2.1. Historique
TechSolutions SARL a été fondée en 2015 et s'est spécialisée dans le développement de solutions logicielles pour les PME. L'entreprise compte aujourd'hui 25 employés et réalise un chiffre d'affaires de 2.5 millions d'euros.

#### 1.2.2. Organisation
- **Direction Générale**: M. Pierre MARTIN
- **Direction Technique**: M. Jean DUPONT
- **Équipe Développement**: 15 développeurs
- **Équipe Support**: 5 techniciens
- **Équipe Commerciale**: 5 commerciaux

#### 1.2.3. Activités
- Développement d'applications mobiles
- Solutions de gestion d'entreprise
- Services de conseil en digitalisation
- Support technique et maintenance

### 1.3. Cadre du projet
#### 1.3.1. Problématique
Les commerçants font face à plusieurs défis dans la gestion de leur point de vente :
- Difficulté de suivi des ventes en temps réel
- Gestion manuelle des stocks
- Absence de rapports détaillés
- Manque de solutions mobiles adaptées

#### 1.3.2. Analyse de l'existant
Les solutions actuelles présentent plusieurs limitations :
- Applications desktop peu pratiques
- Solutions mobiles incomplètes
- Coûts d'implémentation élevés
- Manque de flexibilité

#### 1.3.3. Solution proposée
Notre solution propose :
- Une application mobile complète
- Gestion en temps réel
- Interface intuitive
- Rapports détaillés
- Coût optimisé

#### 1.3.4. Prototypage (Maquettes)
[Voir les maquettes dans l'annexe A]

### 1.4. Analyse et spécification des besoins
#### 1.4.1. Besoins fonctionnels
1. **Gestion des utilisateurs**
   - Authentification
   - Gestion des rôles
   - Profils utilisateurs

2. **Gestion des ventes**
   - Création de ventes
   - Historique des transactions
   - Rapports de ventes

3. **Gestion des stocks**
   - Suivi des produits
   - Alertes de stock
   - Inventaire

4. **Rapports et statistiques**
   - Tableaux de bord
   - Graphiques
   - Export de données

#### 1.4.2. Besoins non fonctionnels
1. **Performance**
   - Temps de réponse < 2 secondes
   - Support de 100+ utilisateurs simultanés

2. **Sécurité**
   - Chiffrement des données
   - Authentification sécurisée
   - Protection des accès

3. **Maintenabilité**
   - Code modulaire
   - Documentation complète
   - Tests automatisés

### 1.5. Gestion du projet
#### 1.5.1. Méthodologie
- Approche agile
- Sprints de 2 semaines
- Réunions quotidiennes
- Revue de sprint

#### 1.5.2. Équipe projet
- 1 Chef de projet
- 2 Développeurs
- 1 Designer
- 1 Testeur

### 1.6. Planification prévisionnelle
[Voir le tableau 1.1 dans les annexes]

### 1.7. Conclusion
Ce chapitre a présenté le contexte général du projet, les besoins identifiés et la planification prévisionnelle. Le prochain chapitre détaillera l'analyse et la conception du système.

## Chapitre 2: Analyse et Conception

### 2.1. Introduction
Ce chapitre présente l'analyse et la conception détaillée du système, en utilisant les méthodes et outils de modélisation appropriés.

### 2.2. Méthodes et outils de modélisation
#### 2.2.1. Langage de modélisation (UML)
- Diagrammes de cas d'utilisation
- Diagrammes de séquence
- Diagrammes de classe
- Diagrammes d'activité

#### 2.2.2. Le Processus Unifié
- Phase d'initialisation
- Phase d'élaboration
- Phase de construction
- Phase de transition

#### 2.2.3. Identification des acteurs et des cas d'utilisation
[Voir le tableau 2.1 dans les annexes]

### 2.3. Diagrammes de cas d'utilisation
[Voir la figure 2.1 dans les annexes]

### 2.4. Étude des Diagrammes de séquences
[Voir la figure 2.2 dans les annexes]

### 2.5. Diagramme de classe
[Voir la figure 2.3 dans les annexes]

### 2.6. Conclusion
L'analyse et la conception ont permis de définir clairement la structure et le fonctionnement du système. Le prochain chapitre présentera la réalisation concrète du projet.

## Chapitre 3: Réalisation du Projet

### 3.1. Introduction
Ce chapitre présente la réalisation concrète du projet, en détaillant les choix techniques et les implémentations effectuées.

### 3.2. Architecture MVC
[Voir la figure 3.1 dans les annexes]

### 3.3. Outils, langage et Framework utilisés
[Voir le tableau 3.1 dans les annexes]

### 3.4. Présentation et description des interfaces
#### 3.4.1. Écran de connexion
[Voir la figure 3.2 dans les annexes]

#### 3.4.2. Tableau de bord administrateur
[Voir la figure 3.3 dans les annexes]

#### 3.4.3. Interface vendeur
[Voir la figure 3.4 dans les annexes]

#### 3.4.4. Page des rapports
[Voir la figure 3.5 dans les annexes]

### 3.5. Conclusion
La réalisation du projet a permis de mettre en œuvre toutes les fonctionnalités prévues, en respectant les contraintes techniques et les délais fixés.

## Conclusion Générale
Ce stage a été une expérience enrichissante qui m'a permis de :
- Développer une application complète
- Travailler en équipe
- Gérer un projet de A à Z
- Acquérir de nouvelles compétences

Les objectifs initiaux ont été atteints, et l'application est prête pour une utilisation en production.

## Annexes
[Voir le fichier annexes.md pour les détails complets]

---

*Rapport rédigé par Ilyas BENALI*
*Date: 31/03/2024* 