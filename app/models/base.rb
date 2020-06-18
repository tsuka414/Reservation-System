class Base < ApplicationRecord
   validates :base_number, uniqueness: true  
end
