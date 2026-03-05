class CocktailsController < ApplicationController
    SPIRIT_COLORS = {
        "gin" => "rgb(70,200,120)",
        "vodka" => "rgb(120,200,255)",
        "rum" => "rgb(0,180,170)",
        "bourbon" => "rgb(220,140,60)",
        "rye" => "rgb(200,110,60)",
        "scotch" => "rgb(150,120,200)",
        "tequila" => "rgb(120,220,90)",
        "mezcal" => "rgb(240,150,70)",
        "brandy_cognac" => "rgb(236,202,152)",
        "other" => "rgb(180,180,180)"
    }

    def index
        @cocktails = Cocktail
            .includes(:publication)
            .joins(:publication)
            .order("publications.publication_year ASC")
        @timeline_data = @cocktails.map do |cocktail|
            {
                name: cocktail.name,
                id: cocktail.id,
                x: cocktail.publication.publication_year,
                y: 0,
                title: cocktail.publication.title,
                author: cocktail.publication.author,
                spirit: cocktail.base_spirit,
                color: SPIRIT_COLORS[cocktail.base_spirit]

            }
        end
    end
    def show
        @cocktail = Cocktail.find(params[:id])
        @photo = @cocktail.photo
        
    end
end
