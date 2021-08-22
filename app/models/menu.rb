class Menu < ApplicationRecord
  belongs_to :store
  has_many :posts
  has_many :users, through: :posts

  accepts_nested_attributes_for :store
end
