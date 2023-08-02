module Entities::V1
    class BlogFormat < Grape::Entity
        expose :id
        expose :title
        expose :content
    end
end