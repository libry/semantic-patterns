class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
 
  def index
    @time = Time.now

    sparql = SPARQL::Client.new("http://localhost:3030/medienprojekt/")
    
    #SELECT ?a
    #WHERE {
    #  ?a ?b <http://www.semanticweb.org/libry/ontologies/2015/11/untitled-ontology-8#scenarios>
    #}
    #LIMIT 10
    
    #query = sparql.select(:a).where([:a, :b, RDF::URI('http://www.semanticweb.org/libry/ontologies/2015/11/untitled-ontology-8#scenarios')]).limit(10)
   
    query = sparql.select(:*).where([
                                      :name, :usableIn, :spanish,
                                      :name, :promotes, :selfOrganized,
                                      :name, :requires, :smallgroup,
                                    ]).limit(10)

    @web_query = Array.new
    
    query.each_solution do |solution|
      @web_query << solution.inspect
    end
   
    @time = Time.now

  end
 
end

