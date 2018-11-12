class LectionsController < ApplicationController
  before_action :set_lection, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index,]
  # GET /lections
  # GET /lections.json
  def index
    @lections = Lection.all
  end

  # GET /lections/1
  # GET /lections/1.json
  def show
  end

  # GET /lections/new
  def new
    @lection = current_user.lections.new
  end

  # GET /lections/1/edit
  def edit
  end

  # POST /lections
  # POST /lections.json
  def create
    @lection = Lection.new(lection_params)
      @lection = current_user.lections.new(lection_params)
    respond_to do |format|
      if @lection.save
        format.html { redirect_to @lection, notice: 'Lection was successfully created.' }
        format.json { render :show, status: :created, location: @lection }
      else
        format.html { render :new }
        format.json { render json: @lection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lections/1
  # PATCH/PUT /lections/1.json
  def update
    respond_to do |format|
      if @lection.update(lection_params)
        format.html { redirect_to @lection, notice: 'Lection was successfully updated.' }
        format.json { render :show, status: :ok, location: @lection }
      else
        format.html { render :edit }
        format.json { render json: @lection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lections/1
  # DELETE /lections/1.json
  def destroy
    @lection.destroy
    respond_to do |format|
      format.html { redirect_to lections_url, notice: 'Lection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lection
      @lection = Lection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lection_params
      params.require(:lection).permit(:title, :description, :speciality, :body, :tags)
    end
end