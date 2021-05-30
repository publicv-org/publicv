class SearchesController < ApplicationController
  def create
    if search_param.present?
      @search = Search.find_or_create_by(query: sanitized_query, locale: I18n.locale.to_s)
      redirect_to search_url(@search)
    else
      flash[:error] = t('flash.searches.query_blank')
      redirect_to root_domain_url
    end
  end

  def show
    @search = Search.friendly.find(params[:id])
    seo_tags_for(@search)
    @search.increment!(:views)
    @total_results = @search.materialized_views_results.count
    @results = @search.materialized_views_results.page(params[:page]).per(10)
    @formatted_results = @results.map do |result|
      next unless result.longitude

      result.formatted_map_results
    end.compact
    respond_to do |format|
      format.html
      format.js { render partial: 'search_results' }
    end
  end

  private

  def search_param
    params.permit(:search_query)[:search_query]
  end

  def sanitized_query
    Search.sanitized_query(search_param)
  end
end
