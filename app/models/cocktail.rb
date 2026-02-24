class Cocktail < ApplicationRecord
    belongs_to :publication

    enum base_spirit {
        gin: 0,
        vodka: 1,
        rum: 2,
        bourbon: 3,
        rye: 4,
        scotch: 5,
        tequila: 6,
        mezcal: 7,
        brandy_cognac: 8,
        other: 9 
    }
end
