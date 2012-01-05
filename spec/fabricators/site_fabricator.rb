Fabricator(:site) do
  	uri { "%s/%s" % [Faker::Internet.domain_name, sequence(:i)] }
	name {"%s, version %s" % [Faker::Lorem.words(3) * ' ' , sequence(:i)] }

end
