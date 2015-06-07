require "net/http"
require "uri"
require "json"

class Users::RegistrationsController < Devise::RegistrationsController

  @isDisabled = true

  def new
    @isDisabled = true
    super # no customization, simply call the devise implementation
  end

  def create
    begin
      #  353084238944
      
     num = params['user']['aadhar']

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
        super
      else
        puts("failure")
        flash[:notice] = 'Please provide correct AADHAAR number.'
        redirect_back_or root_path
      end
      
      rescue MyApp::Error => e
        e.errors.each { |error| resource.errors.add :base, error }
        clean_up_passwords(resource)
        respond_with_navigational(resource) { render_with_scope :new }
      end
  end

  def update
    super # no customization, simply call the devise implementation 
  end

  protected

  def after_sign_up_path_for(resource)
    puts("after sign up")
    '/users/aadhaarotp'
  end

  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end
end
