class GradesController < ApplicationController
  before_action :set_grade, only: [:show, :edit, :update, :destroy]

  # GET /grades
  # GET /grades.json
  def index

    if params[:query_month]

      @begin_day = params[:query_month] + '-01'
      if ['01','03','05','07','08','10','12'].include?(params[:query_month].last(2))
        @end_day = params[:query_month] + '-31'
      elsif ['02'].include?(params[:query_month].last(2))
        @end_day = params[:query_month] + '-28'
      else 
        @end_day = params[:query_month] + '-30'
      end

      @grades = Grade.all.where("date >= '#{@begin_day}' and date <= '#{@end_day}'").order(:date)
    else
      @grades = Grade.where("date >= ? and date <= ?", Time.now().beginning_of_month, Time.now().end_of_month).order(:date)
    end

    @average_grade = @grades.average(:grade)

  end

  # GET /grades/1
  # GET /grades/1.json
  def show
  end

  # GET /grades/new
  def new
    @grade = Grade.new
    @motivatied_word = 
    ["每天努力紀錄，今天比昨天更好，寶貝加油",
     "今天上班辛苦了，回家趕快洗洗睡休息",
     "累累時，看著自己抓到的可愛寶可夢，舒壓吧",
     "上班之餘，也要把握時間運動運動，讓身體更健康唷",
     "充當寶寶們的守護小天使是很辛苦的責任，加油～",
    ].shuffle!.first
  end

  # GET /grades/1/edit
  def edit
  end

  # POST /grades
  # POST /grades.json
  def create
    @grade = Grade.new(grade_params)

    respond_to do |format|
      if @grade.save
        format.html { redirect_to root_path }
        format.json { render :show, status: :created, location: @grade }
      else
        format.html { render :new }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grades/1
  # PATCH/PUT /grades/1.json
  def update
    respond_to do |format|
      if @grade.update(grade_params)
        format.html { redirect_to root_path }
        format.json { render :show, status: :ok, location: @grade }
      else
        format.html { render :edit }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grades/1
  # DELETE /grades/1.json
  def destroy
    @grade.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grade
      @grade = Grade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grade_params
      params.require(:grade).permit(:date, :grade, :description)
    end
end
