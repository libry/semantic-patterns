# A website to search Instructional Pattern in a Semantic Database

## Introduktion
This is a projekt of the Pädagogische Hochschule Weingarten - Master Bildungs- und Medienmanagement  
The website is considered to offer teachers a seach engine and information about Instructional Patterns as part of the EU Erasmus+ [E SIT 4 SIP](http://www.esit4sip.eu/Background.html)  
![alt text](http://www.ph-weingarten.de/grafiken/logo-paedagogische-hochschule-weingarten.gif "Logo PH-Weingarten") 

## Installation (using Windows)

For the Semantic Database we used [Apache Jena Fuseki 2.3.1](https://jena.apache.org/documentation/fuseki2/)

To create and edit OWL files we used [Protégé](http://protege.stanford.edu/products.php#desktop-protege)

### Ruby version and Gems
Ruby on Rails 4.2.6

Additonal used Gems:

- gem [`sparql-client`](https://github.com/ruby-rdf/sparql-client) - Executes queries against any SPARQL 1.0/1.1-compatible endpoint  
- gem [`sprockets`](https://github.com/rails/sprockets) - A Ruby library for compiling and serving web assets like Javascrips and Stylesheets  
- gem [`font-awesome-rails`](https://github.com/rails/sprockets) - Provides the Font-Awesome web fonts and stylesheets as a Rails engine for use with the asset pipeline

## Initialisation (using Windows)

### 1. Jena Fuseki Database 2.3.1
* Start the Jena Fuseki Server - run the `fuseki-server.bat` in your installation folder of the Jena Fuseki Server
* Open `localhost:3030` in your Browser
* Go to 'manage datasets' and add a new dataset. In order to work the dataset name should be `dataset` or you have to change the name in [`application.rb`](../app/controllers/appliaction_controller.rb)  
line `09 sparql = SPARQL::Client.new("http://localhost:3030/dataset/)`
* Upload the new dataset - select files [`dataset.owl`](../dataset.owl)

### 2. Ruby on Rails Server
* Open Windows `cmd` go to the semantic-patterns folder 
* Start the Ruby on Rails Server with the command `rails s` or `rails server`

### 3. Website
* Open `localhost:3000/application` in your Browser to view and use the website 

## Known Issus 
* The asset pipeline for Javascrips and Stylesheets doesn't work properly
* Sometimes the Dropdown doesn't work properly, you can't select a value
* ... 

## Development 
* There should be a Message "No Resulst" if there is nothing found in the Database
* A Funktion to create new database instances
* ...

