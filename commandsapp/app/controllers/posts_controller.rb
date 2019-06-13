class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  

  # GET /posts
  # GET /posts.json
  def index
    #@posts = list_posts
    @posts = Post.all
    #render json: {posts: @posts}
    
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    #render json: {post: @post}
    
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
    user = User.find(session["warden.user.user.key"][0][0])
    post_params_new[:user] = user
    post = Post.new(post_params_new)
    uploaded_io = params[:post][:file]
    if not uploaded_io.nil?
      File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
        file.write(uploaded_io.read)
        post.avatar = file
      end
    end
    uploaded_io = params[:post][:picture]
    if not uploaded_io.nil?
      File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
        file.write(uploaded_io.read)
        post.image = file
      end
    end
    post.open = 1
    @post = post
    respond_to do |format|
      if @post.save
        format.html { redirect_to rant_path(@post["id"]), notice: 'Post was successfully created.' }
        format.json { render :json }
        #render json: @post, status: :created, location: @post
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        #render json: @post.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    post_params_new = post_params
    user = User.find(session["warden.user.user.key"][0][0])
    post_params_new[:user] = user
    uploaded_io = params[:post][:file]
    uploaded_io2 = params[:post][:picture]
    if not uploaded_io.nil?
      File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
        file.write(uploaded_io.read)
        post_params_new[:avatar] = file
        if not uploaded_io2.nil?
          File.open(Rails.root.join('public', 'uploads', uploaded_io2.original_filename), 'wb') do |file|
            file.write(uploaded_io2.read)
            post_params_new[:image] = file
            respond_to do |format|
              if @post.update(post_params_new)
                format.html { redirect_to rant_path(@post.id), notice: 'User was successfully updated.' }
                format.json { render json: {user: @post} }
                #render json: @post
              else
                format.html { render :edit }
                format.json { render json: @post.errors, status: :unprocessable_entity }
                #render json: @post.errors, status: :unprocessable_entity
              end
            end
          end
        else
          respond_to do |format|
            if @post.update(post_params_new)
              format.html { redirect_to rant_path(@post.id), notice: 'User was successfully updated.' }
              format.json { render json: {user: @post} }
              #render json: @post
            else
              format.html { render :edit }
              format.json { render json: @post.errors, status: :unprocessable_entity }
              #render json: @post.errors, status: :unprocessable_entity
            end
          end
        end
      end

    elsif not uploaded_io2.nil?
      File.open(Rails.root.join('public', 'uploads', uploaded_io2.original_filename), 'wb') do |file|
        file.write(uploaded_io2.read)
        post_params_new[:image] = file
        respond_to do |format|
          if @post.update(post_params_new)
            format.html { redirect_to rant_path(@post.id), notice: 'User was successfully updated.' }
            format.json { render json: {user: @post} }
            #render json: @post
          else
            format.html { render :edit }
            format.json { render json: @post.errors, status: :unprocessable_entity }
            #render json: @post.errors, status: :unprocessable_entity
          end
        end
      end
    
    else
      respond_to do |format|
        if @post.update(post_params_new)
          format.html { redirect_to rant_path(@post.id), notice: 'User was successfully updated.' }
          format.json { render json: {user: @post} }
          #render json: @post
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
          #render json: @post.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @comments = Comment.where(post: @post)
    if not @comments.nil?
      @comments.each do |comment|
        comment.destroy
      end
    end
    @votes = Vote.where(post: @post)
    if not @votes.nil?
      @votes.each do |vote|
        vote.destroy
      end
    end
    @dumpsters = Dumpster.where(post: @post)
    if not @dumpsters.nil?
      @dumpsters.each do |dumpster|
        dumpster.destroy
      end
    end
    @post.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Rant was successfully destroyed.' }
      format.json { head :no_content }
    end
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
    #post_info[:files] = Attached.where(post: post)
    @post = post_info
  end

  def upvote
    vote = Vote.where(post: Post.find(params[:id])).where(user: User.find(session["warden.user.user.key"][0][0]))
    @post = Post.find(params[:id])
    if @vote.nil?
      @vote = vote.first
      updated_vote = @vote.attributes
      if @vote.value != 1
        updated_vote[:value] = 1
        updated_vote[:post] = Post.find(params[:id])
        updated_vote[:user] = User.find(session["warden.user.user.key"][0][0])
        #@vote.update(updated_vote)
        respond_to do |format|
          if @vote.update(updated_vote)
            format.html { redirect_to root_path, notice: 'User was successfully updated.' }
            format.json { render json: {user: @post} }
            #format.json { render json: {user: @post} }
            #render json: @post
          else
            redirect_to root_path
            #format.json { render json: @post.errors, status: :unprocessable_entity }
            #render json: @post.errors, status: :unprocessable_entity
          end
        end
      else
        updated_vote[:value] = 0
        updated_vote[:post] = Post.find(params[:id])
        updated_vote[:user] = User.find(session["warden.user.user.key"][0][0])
        @vote.update(updated_vote)
        respond_to do |format|
          if @vote.update(updated_vote)
            format.html { redirect_to root_path, notice: 'User was successfully updated.' }
            format.json { render json: {user: @post} }
            #render json: @post
          else
            redirect_to :back
            #format.json { render json: @post.errors, status: :unprocessable_entity }
            #render json: @post.errors, status: :unprocessable_entity
          end
        end
      end
    else
      new_vote = Vote.new.attributes
      new_vote[:value] = 1
      new_vote[:post] = Post.find(params[:id])
      new_vote[:user] = User.find(session["warden.user.user.key"][0][0])
      @vote = Vote.new(new_vote)
      #@vote.save
      if @vote.save
        format.html { redirect_to root_path, notice: 'User was successfully updated.' }
        format.json { render json: {user: @post} }
      else
        redirect_to :back
      end
    end
=begin
    render json: {
      success: true,
      response: Vote.where(post: Post.find(params[:id])).where(value: 1).count - 
        Vote.where(post: Post.find(params[:id])).where(value: -1).count
    }
=end
  end

  def downvote
    vote = Vote.where(post: Post.find(params[:id])).where(user: User.find(session["warden.user.user.key"][0][0]))
    @post = Post.find(params[:id])
    if @vote.nil?
      @vote = vote.first
      updated_vote = @vote.attributes
      if @vote.value != -1
        updated_vote[:value] = -1
        updated_vote[:post] = Post.find(params[:id])
        updated_vote[:user] = User.find(session["warden.user.user.key"][0][0])
        #@vote.update(updated_vote)
        respond_to do |format|
          if @vote.update(updated_vote)
            format.html { redirect_to root_path, notice: 'User was successfully updated.' }
            format.json { render json: {user: @post} }
            #render json: @post
          else
            redirect_to :back
            #format.json { render json: @post.errors, status: :unprocessable_entity }
            #render json: @post.errors, status: :unprocessable_entity
          end
        end
      else
        updated_vote[:value] = 0
        updated_vote[:post] = Post.find(params[:id])
        updated_vote[:user] = User.find(session["warden.user.user.key"][0][0])
        @vote.update(updated_vote)
        respond_to do |format|
          if @vote.update(updated_vote)
            format.html { redirect_to root_path, notice: 'User was successfully updated.' }
            format.json { render json: {user: @post} }
            #render json: @post
          else
            redirect_to :back
            #format.json { render json: @post.errors, status: :unprocessable_entity }
            #render json: @post.errors, status: :unprocessable_entity
          end
        end
      end
    else
      new_vote = Vote.new.attributes
      new_vote[:value] = -1
      new_vote[:post] = Post.find(params[:id])
      new_vote[:user] = User.find(session["warden.user.user.key"][0][0])
      @vote = Vote.new(new_vote)
      #@vote.save
      if @vote.save
        format.html { redirect_to root_path, notice: 'User was successfully updated.' }
        format.json { render json: {user: @post} }
      else
        redirect_to :back
      end
    end
=begin
    render json: {
      success: true,
      response: Vote.where(post: Post.find(params[:id])).where(value: 1).count - 
        Vote.where(post: Post.find(params[:id])).where(value: -1).count
    }
=end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :creation_date, :description, :location, :open, :solved, :user, :latitude, :longitude, :country)
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
