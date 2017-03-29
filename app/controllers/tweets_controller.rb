class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :set_all, only: [:index]

  def index
    if params[:back]
      @tweet = Tweet.new(tweets_params)
    else
      @tweet = Tweet.new
    end
  end

  def create
    @tweet = Tweet.new(tweets_params)
    @tweet.user_id = current_user.id
    if @tweet.save
      redirect_to tweets_path, notice: "投稿しました！"
      NoticeMailer.sendmail_blog(@tweet).deliver
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

  def show
    @comment = @tweet.comments.build
    @comments = @tweet.comments
  end

  private
    def tweets_params
      params.require(:tweet).permit(:title,:image,:content)
    end

    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def set_all
      @tweets = Tweet.all
    end
end
