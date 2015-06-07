class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_mailbox
  before_action :get_conversation, except: [:index, :empty_trash]
  before_action :get_box, only: [:index]

  def index
    if @box.eql? "inbox"
      @conversations = @mailbox.inbox
    elsif @box.eql? "sent"
      @conversations = @mailbox.sentbox
    else
      @conversations = @mailbox.trash
    end

    @conversations = @conversations.paginate(page: params[:page], per_page: 10)
  end

  def show
    cid = '/aadhaar/'+ params["id"]
    if @conversation.subject.match('Secured') and !params["secured"]
      puts("aadah number")
     puts(current_user['aadhar'])
     num = current_user['aadhar']

     jdata = {"aadhaar-id" => num,"location" => {"type" => "","pincode" => ""},"channel" => "SMS"}

     url = "https://ac.khoslalabs.com/hackgate/hackathon/otp"
     uri = URI.parse(url)
    
     headers = {'Content-Type' => "application/json", 'Accept' => "application/json"}

     http = Net::HTTP.new(uri.host,uri.port)   # Creates a http object
     http.use_ssl = true                                          # When using https
     http.verify_mode = OpenSSL::SSL::VERIFY_NONE
     response = http.post(uri.path,jdata.to_json,headers)

      puts(response.body)

      result = JSON.parse(response.body)["success"]
      if result 
        redirect_to cid
      end
    end
  end

  def mark_as_read
    @conversation.mark_as_read(current_user)
    flash[:success] = 'The conversation was marked as read.'
    redirect_to conversations_path
  end

  def reply
    current_user.reply_to_conversation(@conversation, params[:body])
    flash[:success] = 'Reply sent'
    redirect_to conversation_path(@conversation)
  end

  def destroy
    @conversation.move_to_trash(current_user)
    flash[:success] = 'The conversation was moved to trash.'
    redirect_to conversations_path
  end

  def restore
    @conversation.untrash(current_user)
    flash[:success] = 'The conversation was restored.'
    redirect_to conversations_path
  end

  def empty_trash
    @mailbox.trash.each do |conversation|
      conversation.receipts_for(current_user).update_all(deleted: true)
    end
    flash[:success] = 'Your trash was cleaned!'
    redirect_to conversations_path
  end

  private

  def get_mailbox
    @mailbox ||= current_user.mailbox
  end

  def get_conversation
    @conversation ||= @mailbox.conversations.find(params[:id])
  end

  def get_box
    if params[:box].blank? or !["inbox","sent","trash"].include?(params[:box])
      params[:box] = 'inbox'
    end
    @box = params[:box]
  end

end