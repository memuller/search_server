class Document
  include Mongoid::Document
  field :title, type: String
  field :uri, type: String
  field :excerpt, type: String

  belongs_to :site

  index :title
  index :uri, unique: true
  index :site_ids

  validates_presence_of :title
  validates :uri, presence: true, uniqueness: {case_sensitive: false, message: 'already indexed'}
  validates_presence_of :site

  before_validation :process_site

  def self.query(args={})
    object = Document
    if args.include? :site 
      object = Site.where(:slug => args[:site]).first.documents if args[:site]
      args.delete :site 
    end
    if args.include? :string
      args[:title] = /#{args[:string]}/i if args[:string]
      args.delete :string
    end
    object.where(args)
  end

  def to_param
    "/#{site.slug}/#{id}"
  end

  def process_site
  	unless(self.site.is_a? Site)
  		self.site = Site.parse_and_create(self.uri)
  	end
  end
end
