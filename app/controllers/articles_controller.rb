class ArticlesController < ApplicationController
	before_action :control_article, only: [:new, :create, :edit, :update, :destroy]
	include ArticlesHelper

	def control_article
		unless logged_in?
			flash[:error]  ="You are not authorized for this."
			redirect_to root_path
			return false
		end
	end

	def index
		@articles = Article.all
	end
	def show
		@article = Article.find(params[:id])
		@comment = Comment.new
		@comment.article_id = @article_id
	end
	def new
		@article = Article.new
	end
	def create
		@article = Article.new(article_params)
		@article.save

		flash.notice = "Article '#{@article.title}' Saved!"
		redirect_to article_path(@article)
	end
	def destroy
		@article = Article.find(params[:id])
		@article.destroy

		flash.notice = "Article '#{@article.title}' Deleted!"
		redirect_to articles_path
	end
	def edit
		@article =Article.find(params[:id])
	end
	def update
		@article = Article.find(params[:id])
		@article.update(article_params)

		flash.notice = "Article '#{@article.title}' Updated!"

		redirect_to articles_path(@article)
	end
end
