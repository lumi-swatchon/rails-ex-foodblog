class User < ApplicationRecord
  has_many :posts
  has_many :menus, through: :posts
end
