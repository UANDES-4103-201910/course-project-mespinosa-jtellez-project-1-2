class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    profile = Profile.find(params[:id])
    profile_info = profile.attributes
    profile_info[:posts] = list_posts
    profile_info[:comments] = list_comments
    profile_info[:votes] = list_votes
    @profile = profile_info


  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    profile = profile_params
    user = User.where(email: profile_params[:user]).first
    profile[:user] = user
    @profile = Profile.new(profile)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:picture, :biography, :city, :country, :user)
    end

    def profile_posts
      Post.where(user: User.where(id: Profile.find(params[:id])))
    end

    def profile_comments
      Comment.where(user:User.where(id: Profile.find(params[:id])))
    end

    def profile_votes
      Vote.where(user: User.where(id: Profile.find(params[:id])))
    end

    def list_posts
      post_list = []
      posts = profile_posts
      posts.each do |post|
        post_info = post.attributes
        post_info[:votes] = profile_votes
        post_info[:comments] = profile_comments
        post_list << post_info
      end
      post_list
    end

    def list_comments
      comment_list = []
      posts = profile_comments
      posts.each do |post|
        comment_info = post.attributes
        comment_list << comment_info
      end
      comment_list
    end

    def list_votes
      vote_list = []
      votes = profile_votes
      votes.each do |post|
        vote_info = post.attributes
        vote_list << vote_info
      end
      vote_list
    end
end
