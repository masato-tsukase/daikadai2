class CommentsController < ApplicationController
  def create
    # ログインユーザーに紐付けてインスタンス生成するためbuildメソッドを使用します。
    @comment = current_user.comments.build(comment_params)
    @tweet = @comment.tweet

    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html { redirect_to tweets_path(@tweet), notice: 'コメントを投稿しました。' }
        format.json { render :show, status: :created, location: @comment }
                # JS形式でレスポンスを返します。
        format.js { render :index }
      else
        format.html { render :index }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      @comment = Comment.find(params[:id])
      @comment.destroy
      format.js { render :index }
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    render :edit
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    flash.now[:notice] = '回答を編集しました。'
    render :index
  end

  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:tweet_id, :content)
    end
end
