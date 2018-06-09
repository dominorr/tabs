class TabsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :set_tab, only: [:show, :edit, :update, :destroy]

  # GET /tabs
  # GET /tabs.json
  def index
    @q = Tab.ransack(index_params[:q])
    @tabs = @q.result
  end

  # GET /tabs/1
  # GET /tabs/1.json
  def show
    @chord_root_positions = ChordTab.where(tab_id: @tab.id).map{|e| e.chord}.pluck(:root).zip(@tab.chord_positions)
    @tab_chords = ChordTab.where(tab_id: @tab.id).map{|e| e.chord}
    @favorited = Favorite.where(tab_id: @tab.id, user_id: current_user.try(:id)).any?
    puts "HEEEEEEERE"
    puts @chord_root_positions
  end

  def index_params
    params.permit(:q)
  end

  # GET /tabs/new
  def new
    @tab = Tab.new
    @chords = Chord.all
  end

  # GET /tabs/1/edit
  def edit
    @chords = Chord.all
  end

  # POST /tabs
  # POST /tabs.json
  def create
    @tab = Tab.new(tab_params.except(:chords))
    chords = []
    @chords = Chord.all

    tab_params[:chords].each do |chord_name|
      chords << Chord.find_by(root: chord_name)
    end

    @tab.chords = chords

    respond_to do |format|
      if @tab.save
        format.html { redirect_to @tab, notice: 'Tab was successfully created.' }
        format.json { render :show, status: :created, location: @tab }
      else
        format.html { render :new }
        format.json { render json: @tab.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tabs/1
  # PATCH/PUT /tabs/1.json
  def update
    respond_to do |format|
      chords = []
      
      tab_params[:chords].each do |chord_name|
        chords << Chord.find_by(root: chord_name)
      end

      @tab.chords = chords

      if @tab.update(tab_params.except(:chords))
        format.html { redirect_to @tab, notice: 'Tab was successfully updated.' }
        format.json { render :show, status: :ok, location: @tab }
      else
        format.html { render :edit }
        format.json { render json: @tab.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tabs/1
  # DELETE /tabs/1.json
  def destroy
    @tab.destroy
    respond_to do |format|
      format.html { redirect_to tabs_url, notice: 'Tab was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def favorites
    response = {}
    tab = Tab.find favorites_params[:tab_id]
    favorite = Favorite.where(tab_id: favorites_params[:tab_id], user_id: current_user.id).first

    if favorite
      favorite.destroy
    else
      favorite = Favorite.new(tab_id: favorites_params[:tab_id], user_id: current_user.id)
      favorite.save
    end
    respond_to do |format|
      if favorite
        response[:status] = true
        format.json{ render json: response }
      else
        response[:status] = false
        format.json{ render json: response }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tab
      @tab = Tab.find(params[:id])
    end

    def favorites_params
      params.permit(:tab_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tab_params
      params.require(:tab).permit(:q, :title, :scale, :user_id, :author, :genre, :lyrics, chord_positions: [], chords: [])
    end
end
