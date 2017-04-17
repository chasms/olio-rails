class AddonSerializer < ActiveModel::Serializer
  attributes :id, :url, :initial_width, :initial_height
end
