class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  

  # GET /posts
  # GET /posts.json
  def index
    #@posts = list_posts
    @posts = Post.all
    render json: {posts: @posts}
    
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    render json: {post: @post}
    
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    #upload
    #render json: {params: params}
    post_params_new = post_params
    user = User.where(email: post_params[:user]).first
    post_params_new[:user] = user
    post = Post.new(post_params_new)
    uploaded_io = params[:post][:file]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
      post.avatar = file
    end
    @post = post
    #respond_to do |format|
    if @post.save
      #format.html { redirect_to @user, notice: 'User was successfully created.' }
      #format.json { render :json }
      render json: @post, status: :created, location: @post
    else
      #format.html { render :new }
      #format.json { render json: @user.errors, status: :unprocessable_entity }
      render json: @post.errors, status: :unprocessable_entity
    end
    #end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    post_params_new = post_params
    user = User.where(email: post_params[:user]).first
    post_params_new[:user] = user
      #respond_to do |format|
    if @post.update(post_params_new)
      #format.html { redirect_to @user, notice: 'User was successfully updated.' }
      #format.json { render json: {user: @user} }
      render json: @post
    else
      #format.html { render :edit }
      #format.json { render json: @user.errors, status: :unprocessable_entity }
      render json: @post.errors, status: :unprocessable_entity
    end
    #end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    @posts = Post.all
    render json: {posts: @posts}
  end

  def comments
    post = Post.find(params[:id])
    post_info = post.attributes
    commentaries = []
    post_comments.each do |comment|
      comment_info = comment.attributes
      comment_info[:profile] = Profile.where(user: User.find(comment[:user_id])).first
      comment_info[:user] = User.find(comment[:user_id])
      commentaries << comment_info
    end
    post_info[:comments] = commentaries
    post_info[:votes] = post_votes
    post_info[:user] = User.find(post.user.id)
    post_info[:profile] = Profile.where(user: post.user).first
    @post = post_info
  end

  def photos
    post = Post.find(params[:id])
    post_info = post.attributes
    post_info[:photos] = Image.where(post: post)
    @post = post_info
  end

  def files
    post = Post.find(params[:id])
    post_info = post.attributes
    post_info[:files] = Attached.where(post: post)
    @post = post_info
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :creation_date, :description, :location, :open, :solved, :user)
    end

    def post_comments
      Comment.where(post: params[:id])
    end

    def post_votes
      Vote.where(post: params[:id])
    end

    def list_posts
      post_list = []
      posts = Post.all
      posts.each do |post|
        post_info = post.attributes
        post_info[:votes] = post_votes
        post_info[:comments] = post_comments
        post_list << post_info
      end
      post_list
    end

    def upload
      uploaded_io = params[:post][:file]
      File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
        file.write(uploaded_io.read)
      end
    end
end
