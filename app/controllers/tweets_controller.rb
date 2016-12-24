class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :update, :destroy]
  before_action :set_all, only: [:index, :create, :update, :confirm]
    
  def index
    if params[:back]
      @tweet = Tweet.new(tweets_params)
    else
      @tweet = Tweet.new
    end 
  end
  
  def create
    @tweet = Tweet.new(tweets_params)
    if @tweet.save
      redirect_to tweets_path
    else
      render 'index'
    end
  end
  
  def edit
  end
  
  def update
    if @tweet.update(tweets_params)
      redirect_to tweets_path
    else
      render 'index'
    end
  end
  
  def destroy
    @tweet.destroy
    redirect_to tweets_path
  end
  
  def confirm
    @tweet = Tweet.new(tweets_params)
    render :index if @tweet.invalid?
  end
  
  private
    def tweets_params
      params.require(:tweet).permit(:content)
    end
    
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end
    
    def set_all
      @tweets = Tweet.all
    end
end
