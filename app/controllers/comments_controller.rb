class CommentsController < ApplicationController
  def index
    @commentable = find_commentable
    @comments = @commentable.comments
  end

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        puts name
        return name[0..-4].classify.constantize.find(value)
      end
    end
    nil
  end

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment])
    if @comment.save
      render text: "Comment made!"
    else
      render text: "could not make comment"
    end
  end

end
