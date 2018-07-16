class Projet < ApplicationRecord
  # attr_accessible :equipements_attributes
  belongs_to :user
  has_many :equipements

end
