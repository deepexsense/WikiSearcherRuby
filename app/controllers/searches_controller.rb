class SearchesController < ApplicationController
  skip_before_action :verify_authenticity_token

  require 'rest-client'
  # GET /searches
  # GET /searches.json
  def index
    @search_term = params[:search_bar] ? params[:search_bar] : "tron"
    @result_array = []
    @wiki_page = 'https://en.wikipedia.org/?curid=' #we will get the id from the search_results
    begin
      api_results = RestClient::Resource.new("https://en.wikipedia.org/w/api.php?format=json&action=query&generator=search&gsrnamespace=0&gsrlimit=10&prop=pageimages|extracts&pilimit=max&exintro&explaintext&exsentences=1&exlimit=max&gsrsearch="+@search_term).get
    rescue
      @result_array = [[:"0000",{:pageid =>0000, :title=>@search_term+" not searched.", :extract=>"Are you online?"}]]
      flash[:notice] = "Api not accessed"
    else
      search_results = JSON.parse(api_results, :symbolize_names => true)
      search_results[:query][:pages].each {|result| @result_array << result }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
  def search_params
    params[:search_bar]
  end
end
