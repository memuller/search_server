require 'machinist/mongoid'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

Document.blueprint do
  title { "A title for doc #{sn}" }
  uri { "http://localhost/doc/#{sn}" }
end
