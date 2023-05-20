class SearchesController < ApplicationController

def search
  @search_model = params[:search_model]
  @search_query = params[:search_query]
  search_type = params[:search_type]

  @q = if @search_model == 'User'
         User.ransack(name_cont: @search_query)
       elsif @search_model == 'Book'
         Book.ransack(title_cont: @search_query)
       end

  column = if @search_model == 'User'
             'name'
           elsif @search_model == 'Book'
             'title'
           end

  case search_type
  when 'start'
    query = "#{@search_query}%"
  when 'exact'
    query = @search_query
  when 'end'
    query = "%#{@search_query}"
  end

  @results = @q.result.where("#{column} LIKE ?", query).distinct
end

end
