class CocktailsController < ApplicationController
    def index
        @cocktails = Cocktail
            .includes(:publication)
            .joins(:publication)
            .order("publications.publication_year ASC")
        @timeline_data = @cocktails.map do |cocktail|
            {
                name: cocktail.name,
                x: cocktail.publication.publication_year,
                y: 0,
                title: cocktail.publication.title,
                author: cocktail.publication.author,
                spirit: cocktail.base_spirit
            }
        end
    end
    def show
        @cocktail = Cocktail.find(params[:id])
    end
end
