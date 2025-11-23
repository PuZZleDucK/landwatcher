class Property < ApplicationRecord
    enum :property_type, {
        house: 0,
        flat: 1,
        mansion: 2,
        annex: 3,
        villa: 4
    }
end
