class ReviewRequestsController < ApplicationController
  before_action :set_review_request, only: [:show, :edit, :update, :destroy]

  # GET /review_requests
  # GET /review_requests.json
  def index
    @review_requests = ReviewRequest.all
  end

  # GET /review_requests/1
  # GET /review_requests/1.json
  def show
    @reviews = @review_request.product_reviews
  end

  # GET /review_requests/new
  def new
    @review_request = ReviewRequest.new
  end

  # GET /review_requests/1/edit
  def edit
  end

  # POST /review_requests
  # POST /review_requests.json
  def create
    @review_request = ReviewRequest.new(review_request_params)
    walmart_reviews_service.call

    respond_to do |format|
      if @review_request.save
        format.html { redirect_to @review_request, notice: 'Review request was successfully created.' }
        format.json { render :show, status: :created, location: @review_request }
      else
        format.html { render :new }
        format.json { render json: @review_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /review_requests/1
  # PATCH/PUT /review_requests/1.json
  def update
    respond_to do |format|
      if @review_request.update(review_request_params)
        format.html { redirect_to @review_request, notice: 'Review request was successfully updated.' }
        format.json { render :show, status: :ok, location: @review_request }
      else
        format.html { render :edit }
        format.json { render json: @review_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /review_requests/1
  # DELETE /review_requests/1.json
  def destroy
    @review_request.destroy
    respond_to do |format|
      format.html { redirect_to review_requests_url, notice: 'Review request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review_request
      @review_request = ReviewRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_request_params
      params.require(:review_request).permit(:product_id, :search_text)
    end

    def walmart_reviews_service
      @walmart_reviews_service ||= ::WalmartReviews.new(@review_request)
    end
end
