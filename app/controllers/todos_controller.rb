class TodosController < ApplicationController
  
  before_action :set_todos, exept: [:done]
  before_action :set_twitter, only: [:complete, :tweet]
  
  def set_todos
    @todos = Todo.where(done: nil)
  end
  
  
  def index
    @todo = Todo.new
  end
  
  def create
    todo = Todo.new(todo_params)
    if todo.save
      flash.now[:success] = "作成しました"
      respond_to do |format|
      format.js
      format.html
    end
    
    else
      flash.now[:danger] = "作成に失敗しました"
      render "index"
    end
    
  end
  
  def destroy
     todo = Todo.find(params[:id])
    if todo.destroy
      flash.now[:success] = "削除しました"
      respond_to do |format|
        format.js
        format.html
      end
    end
  end
  
  def complete
    todo = Todo.find(params[:format])
    todo.update(done: todo.id)
    @twitter.update("#{todo.title}完了しました！\n #{Time.now.strftime("%H:%M")}\n(自動送信)")
    flash[:success] = "Tweetしました"
     redirect_to todos_path
  end
  
  def undo
    todo = Todo.find(params[:format])
    todo.update(done: nil)
    redirect_to todos_path
  end
  
  def done
     @todos = Todo.where.not(done: nil)
  end
  
  def tweet
    @twitter.update("#{params[:content]}")
    flash[:success] = "Tweetしました"
    redirect_to todos_path
  end
  
private

 def set_twitter
     @twitter = Twitter::REST::Client.new do |config|
       
       config.consumer_key = ENV["TWITTER_CONSUMER_KEY"]
       config.consumer_secret = ENV["TWITTER_CONSUMER_SECRET"]
       config.access_token = ENV["TWITTER_ACCESS_TOKEN"]
       config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]

      end
  end

def todo_params
  params.require(:todo).permit(:title, :content)
end

end
