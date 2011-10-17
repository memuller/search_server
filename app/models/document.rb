class Document
  include Mongoid::Document
  field :title, type: String
  field :uri, type: String
  field :excerpt, type: String

  index :title
  index :uri, unique: true

  validates_presence_of :title
  validates :uri, presence: true, uniqueness: {case_sensitive: false, message: 'already indexed'}
end
