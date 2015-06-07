require "net/http"
require "uri"
require "json"

class MessagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @chosen_recipient = User.find_by(id: params[:to].to_i) if params[:to]
  end

  def create
    recipients = User.where(id: params['recipients'])
    if params[:message][:secured]["secured"] === "1"
      isSecured = "Secured"
    else
      isSecured = "Non secured"
    end
    conversation = current_user.send_message(recipients, params[:message][:body], isSecured + "-" + params[:message][:subject]).conversation
    flash[:success] = "Message has been sent!"
    redirect_to conversation_path(conversation)
  end

end