class TabsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :set_tab, only: [:show, :edit, :update, :destroy]

  # GET /tabs
  # GET /tabs.json
  def index
    @tabs = Tab.all
  end

  # GET /tabs/1
  # GET /tabs/1.json
  def show
    @chord_root_positions = ChordTab.where(tab_id: @tab.id).map{|e| e.chord}.pluck(:root).zip(@tab.chord_positions)
    @tab_chords = ChordTab.where(tab_id: @tab.id).map{|e| e.chord}
    puts "HEEEEEEERE"
    puts @chord_root_positions
  end

  # GET /tabs/new
  def new
    @tab = Tab.new
    @chords = Chord.all
  end

  # GET /tabs/1/edit
  def edit
  end

  # POST /tabs
  # POST /tabs.json
  def create
    @tab = Tab.new(tab_params.except(:chords))
    chords = []
    puts "PARAAAAAAMS"
    puts tab_params.to_yaml
    tab_params[:chords].each do |chord_name|
      chords << Chord.find_by(root: chord_name)
    end
    puts 'CHOOOOOORD'
    puts chords.pluck(:root)
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
      if @tab.update(tab_params)
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tab
      @tab = Tab.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tab_params
      params.require(:tab).permit(:title, :scale, :author, :genre, :lyrics, chord_positions: [], chords: [])
    end
end
