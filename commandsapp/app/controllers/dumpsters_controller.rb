class DumpstersController < ApplicationController
  before_action :set_dumpster, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /dumpsters
  # GET /dumpsters.json
  def index
    @dumpsters = list_posts
    @blacklists = list_users
  end

  # GET /dumpsters/1
  # GET /dumpsters/1.json
  def show
  end

  # GET /dumpsters/new
  def new
    @dumpster = Dumpster.new
  end

  # GET /dumpsters/1/edit
  def edit
  end

  # POST /dumpsters
  # POST /dumpsters.json
  def create
    @dumpster = Dumpster.new(dumpster_params)

    respond_to do |format|
      if @dumpster.save
        format.html { redirect_to @dumpster, notice: 'Dumpster was successfully created.' }
        format.json { render :show, status: :created, location: @dumpster }
      else
        format.html { render :new }
        format.json { render json: @dumpster.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dumpsters/1
  # PATCH/PUT /dumpsters/1.json
  def update
    respond_to do |format|
      if @dumpster.update(dumpster_params)
        format.html { redirect_to @dumpster, notice: 'Dumpster was successfully updated.' }
        format.json { render :show, status: :ok, location: @dumpster }
      else
        format.html { render :edit }
        format.json { render json: @dumpster.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dumpsters/1
  # DELETE /dumpsters/1.json
  def destroy
    @dumpster.destroy
    respond_to do |format|
      format.html { redirect_to dumpsters_url, notice: 'Dumpster was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy_selected
    params["rants"].each do |rant|
      @dumpster = Dumpster.find(rant.to_i)
      @dumpster.destroy
    end

    respond_to do |format|
      format.html { redirect_to dumpsters_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dumpster
      @dumpster = Dumpster.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dumpster_params
      params.require(:dumpster).permit(:post, :date)
    end

    def dumpster_posts
      Post.where(id: params[:post])
    end

    def post_comments
      Comment.where(post: params[:post])
    end

    def post_votes
      Vote.where(post: params[:post])
    end

    def list_posts
      post_list = []
      posts = Dumpster.all
      posts.each do |post|
        post_info = post.attributes
        post_info[:post] = Post.find(post.post.id)
        post_info[:votes] = post_votes
        post_info[:comments] = post_comments
        post_list << post_info
      end
      post_list
    end

    def list_users
      user_list = []
      users = Blacklist.all
      users.each do |user|
        user_info = user.attributes
        user_info[:user] = User.find(user.user.id)
        user_list << user_info
      end
      user_list
    end

end
