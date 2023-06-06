class Api::V1::ArticlesController < ApplicationController
  before_action :set_article, only: %i[show update destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /api/v1/articles
  def index
    @articles = Article.all
    render json: @articles
  end

  # GET /api/v1/articles/1
  def show
    render json: @article
  end

  # POST /api/v1/articles
  def create
    @article = Article.new(article_params)

    if @article.save
      render json: @article, status: :created
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/articles/1
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/articles/1
  def destroy
    @article.destroy
    head :no_content
  end

  private

  def set_article
    @article = Article.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Article not found' }, status: :not_found
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
