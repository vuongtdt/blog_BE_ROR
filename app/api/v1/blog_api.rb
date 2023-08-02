module V1
    class BlogApi < Grape::API
        resource :blogs do
            get do
                @blogs = Blog.all
                present @blogs, with: Entities::V1::BlogFormat
            end

            params do
                requires :title, type: String
                requires :content, type: String
            end

            post do
                @blog = Blogs.new(title: params[:title], content: params[:content])
                @blog.save
                present @blog, with: Entities::V1::BlogFormat
            end

            route_param :id do
                before do
                    @blog = Blogs.find(params[:id])
                end
               
                get do
                    @blog
                    present @blog, with: Entities::V1::BlogFormat
                end

                params do
                    requires :title, type: String
                    requires :content, type: String
                end
                patch do
                    @blog.update(params)
                    present @blog, with: Entities::V1::BlogFormat
                end

                delete do
                    @blog.destroy
                end
            end  
        end
    end
end