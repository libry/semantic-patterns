class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
 
  def index
    @time = Time.now

    sparql = SPARQL::Client.new("http://localhost:3030/medienprojekt/")
    
    ## SPARQL Query 
    #SELECT ?a
    #WHERE {
    #  ?a ?b <http://www.semanticweb.org/libry/ontologies/2015/11/untitled-ontology-8#scenarios>
    #}
    #LIMIT 10
    
    ## Ruby Test-Query
    #query = sparql.select(:a).where([:a, :b, RDF::URI('http://www.semanticweb.org/libry/ontologies/2015/11/untitled-ontology-8#scenarios')]).limit(10)
   
    #query = sparql.select.prefix(rdf: RDF::URI("http://www.w3.org/1999/02/22-rdf-syntax-ns#")).
    #                      prefix(rdfs: RDF::URI("http://www.w3.org/2000/01/rdf-schema#")).
    #                      prefix(owl: RDF::URI("http://www.w3.org/2002/07/owl#")).
    #                      prefix(xsd: RDF::URI("http://www.w3.org/2001/XMLSchema#")).
    #                      prefix(md: RDF::URI("http://www.semanticweb.org/simon/ontologies/2016/1/medienprojekt#")).
    #                      where([
    #                                  :name, RDF::URI("http://www.semanticweb.org/simon/ontologies/2016/1/medienprojekt#usableIn"), RDF::URI("http://www.semanticweb.org/simon/ontologies/2016/1/medienprojekt#spanish")
                                      #:name md:promotes md:selfOrganized,
                                      #:name md:requires md:smallgroup
    #                                ]).limit(10)
    
    data = Array.new
    
    hash = {:predicate => "usableIn", :object => "mathematics"}
    data.push(hash)
    hash = {:predicate => "promotes", :object => "selfDirected"}
    data.push(hash)
    hash = {:predicate => "includes", :object => "remember"}
    data.push(hash)
    hash = {:predicate => "mediates", :object => "factualKnowledge"}
    data.push(hash)
    hash = {:predicate => "requires", :object => "individualWork"}
    data.push(hash)
    
    query = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
             PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
             PREFIX owl: <http://www.w3.org/2002/07/owl#>
             PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
             PREFIX :  <http://www.semanticweb.org/simon/ontologies/2016/1/medienprojekt#>
            
             SELECT *
             {"
               
    data.each {
                |hash| query = query << "?name :" << hash[:predicate] << " :" << hash[:object] << " .\n"
              }

    query = query << "      }\nLIMIT 400"
    
    puts query
    
    result = sparql.query(query)

    @web_results = Array.new
    
    result.each_solution do |solution|
      @web_results << solution.inspect
    end
   
    @time = Time.now

  end
 
end

