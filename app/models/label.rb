class Label < ApplicationRecord

  has_many :sorts
  has_many :tasks, through: sorts
end
