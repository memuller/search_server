Fabricator :document do
	uri { "http://%s/%s" % [Faker::Internet.domain_name, sequence(:i)] }
	title {"%s, version %s" % [Faker::Lorem.words(3) * ' ' , sequence(:i)] }
end