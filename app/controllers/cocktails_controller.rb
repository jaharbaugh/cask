class CocktailsController < ApplicationController
    def index
        @cocktails = Cocktail
            .includes(:publication)
            .joins(:publication)
            .order("publications.publication_year ASC")
    end
    def show
        @cocktail = Cocktail.find(params[:id])
    end
end
