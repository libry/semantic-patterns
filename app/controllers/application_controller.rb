class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
 
  def index

    # open a connection to the fuseki server
    sparql = SPARQL::Client.new("http://localhost:3030/dataset/")
    
    # generate the dropdown menus for the search options
    @educationalSubjects = get_object_results({:object => "educationalSubjects"}, sparql)
    @arrangement = get_object_results({:object => "arrangement"}, sparql)
    @cognitiveProcess = get_object_results({:object => "cognitiveProcess"}, sparql)
    @learningActivity = get_object_results({:object => "learningActivity"}, sparql)
    @selfDeterminationDegree = get_object_results({:predicate => "rdf:type", :object => "selfDeterminationDegree"}, sparql)
    @competence = get_object_results({:object => "competence"}, sparql)
    @knowledge = get_object_results({:object => "knowledge"}, sparql)
  end
  
  ## Suchanfrage
  
  def search
    # open a connection to the fuseki server
    sparql = SPARQL::Client.new("http://localhost:3030/dataset/")    

    # query header
    query = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
             PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
             PREFIX owl: <http://www.w3.org/2002/07/owl#>
             PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
             PREFIX :  <http://www.semanticweb.org/simon/ontologies/2016/1/medienprojekt#>
            
             SELECT *
             {"

    # disassemble the parameters of the function
    for searchTerm in params[:id].split(',')
      name = searchTerm.split('_')[0]
      if name == 'educationalSubjects'
        predicate = "usableIn"
      end
      if name == 'cognitiveProcess'
        predicate = "includes"
      end
      if name == 'selfDeterminationDegree'
        predicate = "promotes" 
      end
      if name == 'knowledge'
        predicate = "mediates"
      end
      if name == 'arrangement'
        predicate = "requires"
      end
      # add the parameters to the query
      query = query << "?name :" << predicate << " :" << searchTerm.split('_')[1] << " .\n"
    end

    # query footer
    query  = query << "      }\nLIMIT 400"
    
    # send the query to the sparql server and get back the results    
    result = sparql.query(query)
    
    # create correct html entries to pass to the website
    sresult = ""
       
    result.each_solution do |solution|
      sresult << "<li><a href=\"" << solution.inspect[/medienprojekt#.*>/][14..-5].downcase << "\" data-toggle=\"modal\" data-target=\"#" << solution.inspect[/medienprojekt#.*>/][14..-5].downcase << "\" style=\"text-decoration: underline\">" << solution.inspect[/medienprojekt#.*>/][14..-5].capitalize << "</a></li><br>"
    end
    
    # check if results were found, if not display a no results message on the webpage
    if sresult == ""
      sresult = "No results."
    end
 
    @sresult = { "content" => sresult}
 
    # render the results on the webpage
    respond_to do |format|
      format.html
      format.json { render json: @sresult }
    end
    
  end

  ## Generates query strings for objects
  def object_query_generator(data)
    # query header
    query = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
             PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
             PREFIX owl: <http://www.w3.org/2002/07/owl#>
             PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
             PREFIX :  <http://www.semanticweb.org/simon/ontologies/2016/1/medienprojekt#>
            
             SELECT *
             {"
    
    # combine the parameters with the query
    data.each {
                |hash| if hash.has_key?(:predicate)
                         # its possible to have predicate and object parameters 
                         query = query << "?name " << hash[:predicate] <<  " :" << hash[:object] << " .\n"
                       else
                         # or just an object parameter
                         query = query << "?name ?predicate :" << hash[:object] << " .\n"
                       end
            }

    # query footer
    query = query << "      }\nLIMIT 400"
    # return the resulting query
    return query
  end
  
  # get back the options for object parameters  
  def get_object_results(hash, sparql)

    # create a new Array to parameterize the query generation
    data = Array.new
    
    data.push(hash)
    
    # generate the query
    query = object_query_generator(data)
    
    # send the query to the sparql database and get back the results
    result = sparql.query(query)
    
    # create a data structure to pass data to the webpage and safe the results in it
    return_value = Array.new
    
    result.each_solution do |solution|
      return_value << solution.inspect
    end
    
    return return_value
  end
end
