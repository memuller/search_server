class Site
  include Mongoid::Document
  field :name, type: String
  field :uri, type: String
  field :slug, type: String

  has_many :documents, :dependent => :destroy

  index :name
  index :uri, unique: true
  index :slug, unique: true
  index :document_ids

  validates_presence_of :name
  validates :uri, presence: true, uniqueness: { case_sensitive: false, message: 'already here' }
  validates :slug, presence: true, uniqueness: true
      
  before_validation :assign_slug

  def self.parse_and_create(url)
  	url = URI.parse(url)
  	unless site = Site.where( uri: url.host ).first
  		site = Site.create!(name: url.host , uri: url.host)
  	end
  	site
  rescue
    nil
  end

  def to_param
    "#{self.slug}"
  end

  private
  def assign_slug
    if self.new_record? or ! self.slug  
      generate_slug
      while Site.where(slug: self.slug).size > 0
        self.slug += "0" unless self.slug[-1] =~ /^[0-9]+$/ 
        self.slug[-1] = self.slug[-1].to_i.next.to_s
      end
    end
  end

  def generate_slug
    self.slug = URI.parse('http://' + self.uri).host.split('.').first
  end

end