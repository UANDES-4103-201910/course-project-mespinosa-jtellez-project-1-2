class BlacklistsController < ApplicationController
  before_action :set_blacklist, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /blacklists
  # GET /blacklists.json
  def index
    @blacklists = list_users
    #render json: @blacklists
  end

  # GET /blacklists/1
  # GET /blacklists/1.json
  def show
  end

  # GET /blacklists/new
  def new
    @blacklist = Blacklist.new
  end

  # GET /blacklists/1/edit
  def edit
  end

  # POST /blacklists
  # POST /blacklists.json
  def create
    @blacklist = Blacklist.new(blacklist_params)

    respond_to do |format|
      if @blacklist.save
        format.html { redirect_to @blacklist, notice: 'Blacklist was successfully created.' }
        format.json { render :show, status: :created, location: @blacklist }
      else
        format.html { render :new }
        format.json { render json: @blacklist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blacklists/1
  # PATCH/PUT /blacklists/1.json
  def update
    respond_to do |format|
      if @blacklist.update(blacklist_params)
        format.html { redirect_to @blacklist, notice: 'Blacklist was successfully updated.' }
        format.json { render :show, status: :ok, location: @blacklist }
      else
        format.html { render :edit }
        format.json { render json: @blacklist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blacklists/1
  # DELETE /blacklists/1.json
  def destroy
    @blacklist.destroy
    respond_to do |format|
      format.html { redirect_to blacklists_url, notice: 'Blacklist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy_selected
    params["users"].each do |user|
      @blacklist = Blacklist.find(user.to_i)
      @blacklist.destroy
    end

    respond_to do |format|
      format.html { redirect_to blacklists_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blacklist
      @blacklist = Blacklist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blacklist_params
      params.require(:blacklist).permit(:date, :user)
    end

    def list_users
      user_list = []
      blacklist = Blacklist.all
      blacklist.each do |entry|
        entry_info = entry.attributes
        entry_info[:user] = User.find(entry.user.id)
        user_list << entry_info
      end
      user_list
    end
end
