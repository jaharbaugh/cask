class Publication < ApplicationRecord
    has_many :cocktails, dependent: :destroy

    enum publication_type: {
        book: 0,
        magazine: 1,
        menu: 2,
        website: 3
    }
end
