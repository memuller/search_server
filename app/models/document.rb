class Document
  include Mongoid::Document
  field :title, type: String
  field :uri, type: String
  field :excerpt, type: String

  has_and_belongs_to_many :sites

  index :title
  index :uri, unique: true
  index :site_ids

  validates_presence_of :title
  validates :uri, presence: true, uniqueness: {case_sensitive: false, message: 'already indexed'}


end
