class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = current_user.messages.create(message_params)
    if @message.save
      redirect_to messages_path, notice: "Message sent"
    else
      redirect_to messages_path, alert: "Please try again"
    end
  end

  def index
    @messages = current_user.messages
    @true_relations = Relation.where("relations.user_id = ?", current_user.id)
    @messages.each { |n| n.update_attribute(:seen, true) }
  end

  protected
  def message_params
    params.require(:message).permit(:recipient_id, :content, :seen)
  end
end
