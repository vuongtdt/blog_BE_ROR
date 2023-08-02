class BlogsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_blog, only: [:show, :update, :detroy]

    def index
        @blogs = Blog.all
        render json: @blogs
    end

    def show
        render json: @blog
    end

    def create
        @blog = Blog.new(blog_params)
        if @blog.save
            render json: @blog, status: :created
        else
            render json: @blog.errors, status: :unprocessable_entity
        end
    end

    def update
        if @blog.update(blog_params)
            render json: @blog
        else
            render json: @blog.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @blog.destroy
        head :no_content
    end

    private
    def set_blog
        @blog = Blog.find(params[:id])
    end

    def blog_params
        params.require(:blog).permit(:title, :content)
    end
end