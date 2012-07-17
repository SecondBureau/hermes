class Template
  include DataMapper::Resource
  property :id,   Serial
  property :title, String
  property :created_at, DateTime
  property :updated_at, DateTime
end