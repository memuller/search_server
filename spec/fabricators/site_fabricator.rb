Fabricator(:site) do
  title { "My %s site about %s" % [Faker::Lorem.words(3) * '', sequence(:i)] }
  	uri { "http://%s/%s" % [Faker::Internet.domain_name, sequence(:i)] }
	name {"%s, version %s" % [Faker::Lorem.words(3) * ' ' , sequence(:i)] }

end
