class TrainSerializer < ActiveModel::Serializer
  attributes :id, :symbol, :origin, :destination, :frequency, :notes, :description, :railroad
end
