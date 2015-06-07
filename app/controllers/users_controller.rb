require "net/http"
require "uri"
require "json"

class UsersController < ApplicationController
  def index
    @users = User.order('created_at DESC').paginate(page: params[:page], per_page: 30)
  end

  def update

  	puts("update path")

    @user = User.find(current_user.id)
    if @user
    	num = params['otp']

	   jdata = {"aadhaar-id" => "353084238944","location" => {"type" => "pincode","pincode" => "600064"} ,"modality" => "otp", "device-id" => "public", "certificate-type" => "preprod", "otp" => num, "channel" => "SMS" }

	   puts(jdata.to_json)

	   url = "https://ac.khoslalabs.com/hackgate/hackathon/auth/raw"
	   uri = URI.parse(url)
	  
	   headers = {'Content-Type' => "application/json", 'Accept' => "application/json"}

	   http = Net::HTTP.new(uri.host,uri.port)   # Creates a http object
	   http.use_ssl = true                                          # When using https
	   http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	  response = http.post(uri.path,jdata.to_json,headers)

	  puts(response.body)

	  result = JSON.parse(response.body)["success"]

	  result = true

	  if result
	  	redirect_to new_user_session_path
	  else
	  	puts("failure")
	  	User.where(:email=>current_user["email"]).delete_all
        flash[:notice] = 'Please provide correct AADHAAR number.'
        redirect_to new_user_registration_path
	  end

    else
      render "edit"
    end
  end

   def aadhaarotp1
    puts(params)
     @user = User.find(current_user.id)
    if @user
    	num = params['otp']

	   jdata = {"aadhaar-id" => @user.aadhar,"location" => {"type" => "pincode","pincode" => "600064"} ,"modality" => "otp", "device-id" => "public", "certificate-type" => "preprod", "otp" => num, "channel" => "SMS" }

	   puts(jdata.to_json)

	   url = "https://ac.khoslalabs.com/hackgate/hackathon/auth/raw"
	   uri = URI.parse(url)
	  
	   headers = {'Content-Type' => "application/json", 'Accept' => "application/json"}

	   http = Net::HTTP.new(uri.host,uri.port)   # Creates a http object
	   http.use_ssl = true                                          # When using https
	   http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	  response = http.post(uri.path,jdata.to_json,headers)

	  puts(response.body)

	  result = JSON.parse(response.body)["success"]

	  if result
	  	urln = '/conversations/' + params["cid"] + '/true'
	  	redirect_to urln
	  else
	  	puts("failure")
        flash[:notice] = 'Please provide correct OTP value.'
        redirect_to conversations_path
	  end

    else
      render "edit"
    end
  end

end