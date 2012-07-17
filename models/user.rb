class User
  include DataMapper::Resource
  property :id,   Serial
  property :contact, String
  property :email, String
  property :token, String
  property :last_read_at, DateTime
  property :read_count, Integer, :default => 0
  property :created_at, DateTime
  property :updated_at, DateTime
  property :sent_at, DateTime

end
