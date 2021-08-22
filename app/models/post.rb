class Post < ApplicationRecord
  belongs_to :user
  belongs_to :menu

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :menu
end
