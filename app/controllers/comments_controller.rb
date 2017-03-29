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

  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:tweet_id, :content)
    end
end
