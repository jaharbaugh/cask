# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

p1 = Publication.create!(
    title: "Mayahuel", 
    author: "Phil Ward", 
    publication_type: :menu, 
    publication_year: 2009
    )
Cocktail.create!(name: "Bushwick", base_spirit: :rye, publication: p1)

p2 = Publication.create!(
    title: "The Violet Hour", 
    author: "Sam Ross", 
    publication_type: :menu, 
    publication_year: 2008
    )
Cocktail.create!(name: "Paper Plane", base_spirit: :bourbon, publication: p2)

p3 = Publication.create!(
    title: "Drinks--Long and Short", 
    author: "Nina Toye & A.H. Adair", 
    publication_type: :book, 
    publication_year: 1925
    )
Cocktail.create!(name: "Champs-Élysées", base_spirit: :brandy_cognac, publication: p3)

p4 = Publication.create!(
    title: "Fred's Club", 
    author: "Dick Bradsell", 
    publication_type: :menu, 
    publication_year: 1983
    )
Cocktail.create!(name: "Espresso Martini", base_spirit: :vodka, publication: p4)

p5 = Publication.create!(
    title: "Straub's Manual of Mixed Drinks", 
    author: "Jacques Straub", 
    publication_type: :book, 
    publication_year: 1913
    )
Cocktail.create!(name: "Emerson", base_spirit: :gin, publication: p5)

p6 = Publication.create!(
    title: "J. Rieger & Co", 
    author: "Andrew Olsen", 
    publication_type: :menu, 
    publication_year: 2017
    )
Cocktail.create!(name: "Kansas City Ice Water", base_spirit: :vodka, publication: p6)

p7 = Publication.create!(
    title: "Milady's", 
    author: "Julie Reiner", 
    publication_type: :menu, 
    publication_year: 2023
    )
Cocktail.create!(name: "Milady's Martini", base_spirit: :gin, publication: p7)

p8 = Publication.create!(
  title: "The Savoy Cocktail Book",
  author: "Harry Craddock",
  publication_type: :book,
  publication_year: 1930
)
Cocktail.create!(name: "Corpse Reviver No. 2", base_spirit: :gin, publication: p8)
Cocktail.create!(name: "Hanky Panky", base_spirit: :gin, publication: p8)

p9 = Publication.create!(
  title: "PDT Cocktail Book",
  author: "Jim Meehan",
  publication_type: :book,
  publication_year: 2011
)
Cocktail.create!(name: "Benton's Old Fashioned", base_spirit: :bourbon, publication: p9)
Cocktail.create!(name: "Oaxaca Old Fashioned", base_spirit: :tequila, publication: p9)

p10 = Publication.create!(
  title: "Harry's ABC of Mixing Cocktails",
  author: "Harry MacElhone",
  publication_type: :book,
  publication_year: 1922
)
Cocktail.create!(name: "Monkey Gland", base_spirit: :gin, publication: p10)

p11 = Publication.create!(
  title: "Beachbum Berry's Grog Log",
  author: "Jeff Berry",
  publication_type: :book,
  publication_year: 1998
)
Cocktail.create!(name: "Zombie", base_spirit: :rum, publication: p11)
Cocktail.create!(name: "Navy Grog", base_spirit: :rum, publication: p11)

p12 = Publication.create!(
  title: "Beachbum Berry Remixed",
  author: "Jeff Berry",
  publication_type: :book,
  publication_year: 2009
)
Cocktail.create!(name: "Missionary's Downfall", base_spirit: :rum, publication: p12)

p13 = Publication.create!(
  title: "Death & Co",
  author: "David Kaplan, Nick Fauchald, Alex Day",
  publication_type: :book,
  publication_year: 2014
)
Cocktail.create!(name: "Oaxacanite", base_spirit: :tequila, publication: p13)
Cocktail.create!(name: "Conference", base_spirit: :rye, publication: p13)
Cocktail.create!(name: "Naked and Famous", base_spirit: :mezcal, publication: p13)

p14 = Publication.create!(
  title: "Mr. Boston Official Bartender's Guide",
  author: "Anthony Giglio (ed.)",
  publication_type: :book,
  publication_year: 1935
)
Cocktail.create!(name: "Algonquin", base_spirit: :rye, publication: p14)
Cocktail.create!(name: "Income Tax", base_spirit: :gin, publication: p14)
Cocktail.create!(name: "Between the Sheets", base_spirit: :brandy_cognac, publication: p14)

p15 = Publication.create!(
  title: "How to Mix Drinks", 
  author: "Jerry Thomas", 
  publication_type: :book, 
  publication_year: 1862
)

Cocktail.create!(name: "Sherry Cobbler", base_spirit: :other, publication: p15)
Cocktail.create!(name: "Brandy Crusta", base_spirit: :brandy_cognac, publication: p15)
Cocktail.create!(name: "Gin Punch", base_spirit: :gin, publication: p15)

p16 = Publication.create!(
  title: "Bartender's Manual", 
  author: "Harry Johnson", 
  publication_type: :book, 
  publication_year: 1882
)

Cocktail.create!(name: "Martinez", base_spirit: :gin, publication: p16)
Cocktail.create!(name: "Improved Whiskey Cocktail", base_spirit: :rye, publication: p16)

p17 = Publication.create!(
  title: "The Ideal Bartender", 
  author: "Tom Bullock", 
  publication_type: :book, 
  publication_year: 1917
)

Cocktail.create!(name: "Clover Club", base_spirit: :gin, publication: p17)
Cocktail.create!(name: "Gillette Cocktail", base_spirit: :gin, publication: p17)

p18 = Publication.create!(
  title: "Don the Beachcomber Menu", 
  author: "Donn Beach", 
  publication_type: :menu, 
  publication_year: 1934
)

Cocktail.create!(name: "Zombie", base_spirit: :rum, publication: p18)
Cocktail.create!(name: "Cobra's Fang", base_spirit: :rum, publication: p18)

p19 = Publication.create!(
  title: "Esquire Magazine", 
  author: "Esquire Editors", 
  publication_type: :magazine, 
  publication_year: 1953
)

Cocktail.create!(name: "Black Russian", base_spirit: :vodka, publication: p19)
Cocktail.create!(name: "Golden Cadillac", base_spirit: :other, publication: p19)

p20 = Publication.create!(
  title: "Playboy's Host & Bar Book", 
  author: "Thomas Mario", 
  publication_type: :book, 
  publication_year: 1961
)

Cocktail.create!(name: "Rusty Nail", base_spirit: :scotch, publication: p20)
Cocktail.create!(name: "Stinger", base_spirit: :brandy_cognac, publication: p20)

p21 = Publication.create!(
  title: "Sunset Magazine", 
  author: "Sunset Editors", 
  publication_type: :magazine, 
  publication_year: 1971
)

Cocktail.create!(name: "Tequila Sunrise", base_spirit: :tequila, publication: p21)
Cocktail.create!(name: "Harvey Wallbanger", base_spirit: :vodka, publication: p21)

p22 = Publication.create!(
  title: "Cosmopolitan Magazine", 
  author: "Cosmopolitan Editors", 
  publication_type: :magazine, 
  publication_year: 1978
)

Cocktail.create!(name: "Amaretto Sour", base_spirit: :other, publication: p22)
Cocktail.create!(name: "Alabama Slammer", base_spirit: :bourbon, publication: p22)

p23 = Publication.create!(
  title: "Mr. Boston Official Bartender's Guide", 
  author: "Anthony Giglio", 
  publication_type: :book, 
  publication_year: 1980
)

Cocktail.create!(name: "Sex on the Beach", base_spirit: :vodka, publication: p23)
Cocktail.create!(name: "Fuzzy Navel", base_spirit: :other, publication: p23)