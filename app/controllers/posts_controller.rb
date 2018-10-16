class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  require 'rest-client'
  require 'json'

  BASE_URL = "http://localhost:3000"

  # GET /posts
  # GET /posts.json
  def index
    url = RestClient.get "#{BASE_URL}/posts"
    @posts = JSON.parse(url, :symbolize_names => true)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
  end

  # GET /posts/1/edit
  def edit
    set_post
  end

  # POST /posts
  # POST /posts.json
  def create
    url = "#{BASE_URL}/posts"
    aux = RestClient::Resource.new(url)

    aux.post params.to_json, :content_type => "application/json"
    redirect_to posts_path
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    url = "#{BASE_URL}/posts/#{params[:id]}"
    aux = RestClient::Resource.new(url)

    aux.put params.to_json, :content_type => "application/json"
    redirect_to posts_path
    
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    url = "#{BASE_URL}/posts/#{params[:id]}"
    aux = RestClient::Resource.new(url)
    aux.delete
    redirect_to posts_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      url = "#{BASE_URL}/posts/#{params[:id]}"
      aux = RestClient::Resource.new(url)
      @post = JSON.parse(aux.get, :symbolize_names => true) 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:body)
    end
  end
