class SystemStatsController < ApplicationController
  before_action :set_system_stat, only: [:show, :edit, :update, :destroy]

  # GET /system_stats
  # GET /system_stats.json
  def index
    @system_stats = SystemStat.all
  end

  # GET /system_stats/1
  # GET /system_stats/1.json
  def show
  end

  # GET /system_stats/new
  def new
    @system_stat = SystemStat.new
  end

  # GET /system_stats/1/edit
  def edit
  end

  # POST /system_stats
  # POST /system_stats.json
  def create
    @system_stat = SystemStat.new(system_stat_params)

    respond_to do |format|
      if @system_stat.save
        format.html { redirect_to @system_stat, notice: 'System stat was successfully created.' }
        format.json { render action: 'show', status: :created, location: @system_stat }
      else
        format.html { render action: 'new' }
        format.json { render json: @system_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /system_stats/1
  # PATCH/PUT /system_stats/1.json
  def update
    respond_to do |format|
      if @system_stat.update(system_stat_params)
        format.html { redirect_to @system_stat, notice: 'System stat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @system_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /system_stats/1
  # DELETE /system_stats/1.json
  def destroy
    @system_stat.destroy
    respond_to do |format|
      format.html { redirect_to system_stats_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system_stat
      @system_stat = SystemStat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def system_stat_params
      params.require(:system_stat).permit(:user_cpu, :sys_cpu, :load_1, :load_5, :load_15)
    end
end
