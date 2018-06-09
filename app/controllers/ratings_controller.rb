class RatingsController < ApplicationController
  before_action :set_rating, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  protect_from_forgery prepend: true
  before_action :authenticate_user!
  # GET /ratings
  # GET /ratings.json
  def index
    @ratings = Rating.all
  end

  # GET /ratings/1
  # GET /ratings/1.json
  def show
  end

  # GET /ratings/new
  def new
    @rating = Rating.new

  end

  # GET /ratings/1/edit
  def edit
  end

  # POST /ratings
  # POST /ratings.json
  def create
    puts "PARAAAAAAMS"
    puts rating_params.to_yaml
    puts "IDDDD"
    puts rating_params[:tab_id]
    @tab = Tab.find(rating_params[:tab_id])
    response ={}

    @rating = Rating.new(rating_params)
    @rating.user = current_user

    respond_to do |format|
      if @rating.save
        response['likes_percentage'] = @tab.likes_percentage * 2
        response['dislikes_percentage'] = @tab.dislikes_percentage * 2
        response['number_of_likes'] = @tab.get_likes.size
        response['number_of_dislikes'] = @tab.get_dislikes.size
        format.json { render json: response}
      else
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end

    end
  end

  # PATCH/PUT /ratings/1
  # PATCH/PUT /ratings/1.json
  def update
    respond_to do |format|
      if @rating.update(rating_params)
        format.html { redirect_to @rating, notice: 'Rating was successfully updated.' }
        format.json { render :show, status: :ok, location: @rating }
      else
        format.html { render :edit }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.json
  def destroy
    @rating.destroy
    respond_to do |format|
      format.html { redirect_to ratings_url, notice: 'Rating was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rating_params
      params.require(:rating).permit(:value, :user_id, :tab_id)
    end
end
