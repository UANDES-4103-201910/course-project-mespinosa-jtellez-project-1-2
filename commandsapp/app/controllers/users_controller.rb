class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :except => [:new]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    render json: {user: @user}
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :json }
        #render json: @user, status: :created, location: @user
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        #render json: @user.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
    if @user.update(user_params)
      format.html { redirect_to profile_path(@user.id), notice: 'User was successfully updated.' }
      format.json { render json: {user: @user} }
    else
      format.html { render :edit }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
    end
  end

  # DELETE /users/1 
  # DELETE /users/1.json
  def destroy
    @user.destroy
    @users = User.all
    render json: {users: @users}

    #respond_to do |format|
    #  format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    #  format.json { head :json }
    #end
  end

  def destroy_selected
    Administrator.destroy(params[:administrators])

    respond_to do |format|
      format.html { redirect_to administrators_path }
      format.json { head :no_content }
    end
  end

  def destroy_selected_user
    @user = User.find(params[:id])
    @posts = Post.where(user: @user)
    if @posts.present?
      @posts.each do |post|
        comments = Comment.where(post: post)
        if comments.present?
          comments.each do |comment|
            comment.destroy
          end
        end
        votes = Vote.where(post: post)
        if votes.present?
          votes.each do |vote|
            vote.destroy
          end
        end
        dumpsters = Dumpster.where(post: post)
        if dumpsters.present?
          dumpsters.each do |dumpster|
            dumpster.destroy
          end
        end
        post.destroy
      end
    end
    @administrator = Administrator.where(user: @user)
    if @administrator.present?
      @administrator.first.destroy
    end
    @comments = Comment.where(user: @user)
    if @comments.present?
      @comments.each do |comment|
        comment.destroy
      end
    end
    @votes = Vote.where(user: @user)
    if @votes.present?
      @votes.each do |vote|
        vote.destroy
      end
    end
    @profile = Profile.find(params[:id])
    @profile.destroy
    @blacklist = Blacklist.where(user: @user)
    if @blacklist.present?
      @blacklist.destroy
    end
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'User was successfully destroyed.' }
      format.json { head :json }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :name)
    end

    def user_posts
      Post.where(user: User.find(params[:id]))
    end

    def user_comments
      Comment.where(user: User.find(params[:id]))
    end
end
