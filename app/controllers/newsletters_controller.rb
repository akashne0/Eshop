class NewslettersController < ApplicationController
  before_action :set_newsletter, only: %i[ show edit update destroy ]

  # GET /newsletters or /newsletters.json
  def index
    @newsletters = Newsletter.all
    @newsletter = Newsletter.new
    @categories = Category.all
    @subscription_type = ['Daily', 'Weekly']
  end

  # GET /newsletters/1 or /newsletters/1.json
  def show
  end

  # GET /newsletters/new
  def new
    @newsletter = Newsletter.new
  end

  # GET /newsletters/1/edit
  def edit
  end

  # POST /newsletters or /newsletters.json
  def create
    @newsletter = Newsletter.new(newsletter_params)

    respond_to do |format|
      if @newsletter.save
        NewsletterNotifierMailer.send_subscribed_email(@newsletter).deliver

        format.html { redirect_to newsletters_url, notice: "Please Check Your Email And Confirm!" }
        format.json { render :show, status: :created, location: @newsletter }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @newsletter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /newsletters/1 or /newsletters/1.json
  def update
    respond_to do |format|
      if @newsletter.update(newsletter_params)
        format.html { redirect_to newsletter_url(@newsletter), notice: "Newsletter was successfully updated." }
        format.json { render :show, status: :ok, location: @newsletter }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @newsletter.errors, status: :unprocessable_entity }
      end
    end
  end

  def subscribe
    if params.include? "email"
      @newsletter_user = Newsletter.where(email: params[:email]).first
      
      if @newsletter_user.confirmed_at.nil?
        @newsletter_user.confirmed_at = Time.now
        @newsletter_user.save!
        flash[:notice]='Your Subscription To Newsletter Is Confirmed!'
        redirect_to root_url
      else
        flash[:notice]='You are Already Subscribed to Newsletter!'
        redirect_to newsletters_url
      end
    else
      flash[:notice]='Email Id Is Missing!'
      redirect_to root_url
    end

  end

  def unsubscribe
    if params.include? "email"
      @newsletter_user = Newsletter.where(email: params[:email]).first
      
      unless @newsletter_user.confirmed_at.nil?
        @newsletter_user.confirmed_at = nil
        @newsletter_user.save!
        flash[:notice]='You Have Unsubscribed To Newsletter!'
        redirect_to root_url
      else
        flash[:notice]='You are Already Unsubscribed to Newsletter!'
        redirect_to newsletters_url
      end
    else
      flash[:notice]='Email Id Is Missing!'
      redirect_to root_url
    end

  end

  # DELETE /newsletters/1 or /newsletters/1.json
  def destroy
    @newsletter.destroy

    respond_to do |format|
      format.html { redirect_to newsletters_url, notice: "Newsletter was successfully unsubscribed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_newsletter
      @newsletter = Newsletter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def newsletter_params
      params.require(:newsletter).permit(:email, :subscription_type, categories:[])
    end
end
