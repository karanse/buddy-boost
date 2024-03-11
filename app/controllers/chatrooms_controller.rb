class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    if @chatroom.save
      redirect_to match_chatroom_path(@chatroom.match, @chatroom)
    else
      redirect_to match_path(@chatroom.match)
    end
  end

  private

  def chatroom_params
    params.require(:chatroom).permit(:match_id, :sender_id, :receiver_id)
  end
  
end
