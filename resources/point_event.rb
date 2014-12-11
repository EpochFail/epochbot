class PointEvent < Sequel::Model
  many_to_one :user
  plugin :serialization, :json, :data
end