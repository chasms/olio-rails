class CategoryWithAddonsSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :addons
end
