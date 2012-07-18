class Template
  include DataMapper::Resource
  property :id,   Serial
  property :title, Text
  property :sender, String
  property :created_at, DateTime
  property :updated_at, DateTime
end
