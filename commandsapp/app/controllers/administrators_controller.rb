class AdministratorsController < ApplicationController
  before_action :set_administrator, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /administrators
  # GET /administrators.json
  def index
    administrators = Administrator.all
    admin_list = []
    administrators.each do |admin|
      admin_info = admin.attributes
      admin_info[:user] = User.find(admin["user_id"])
      admin_info[:geofence] = Geofence.find(admin["geofence_id"])
      admin_list << admin_info
    end
    @administrators = admin_list
  end

  # GET /administrators/1
  # GET /administrators/1.json
  def show
  end

  # GET /administrators/new
  def new
    @administrator = Administrator.new
  end

  # GET /administrators/1/edit
  def edit
  end

  # POST /administrators
  # POST /administrators.json
  def create
    @user = User.find(params[:id])
    user = @user.attributes
    user["role"] = 2
    @user.update!(user)
    admin_params = Administrator.new.attributes
    admin_params["superadmin"] = 0
    admin_params["user"] = @user
    admin_params["geofence"] = Geofence.first
    @administrator = Administrator.new(admin_params)
    respond_to do |format|
      if @administrator.save
        format.html { redirect_to administrators_path, notice: 'Administrator was successfully created.' }
        format.json { render :show, status: :created, location: @administrator }
      else
        format.html { render :new }
        format.json { render json: @administrator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administrators/1
  # PATCH/PUT /administrators/1.json
  def update
    params = administrator_params
    geofence = Geofence.find(params[:geofence])
    params[:geofence] = geofence

    respond_to do |format|
      if @administrator.update(params)

        format.html { redirect_to administrators_path, notice: 'Administrator was successfully updated.' }
        format.json { render :show, status: :ok, location: @administrator }
      else
        format.html { render :edit }
        format.json { render json: @administrator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administrators/1
  # DELETE /administrators/1.json
  def destroy
    @administrator.destroy
    respond_to do |format|
      format.html { redirect_to administrators_url, notice: 'Administrator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy_selected
    params["administrators"].each do |admin|
      @administrator = Administrator.find(admin.to_i)
      @user = User.find(@administrator.user_id)
      user = @user.attributes
      user["role"] = 1
      @user.update(user)
      @administrator.destroy
    end

    respond_to do |format|
      format.html { redirect_to administrators_path }
      format.json { head :no_content }
    end
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administrator
      @administrator = Administrator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administrator_params
      params.require(:administrator).permit(:last_access, :superadmin, :geofence, :user)
    end

end
