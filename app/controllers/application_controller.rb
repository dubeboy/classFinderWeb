class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :
  require 'venue_finder_lib'
  helper_method :current_user
  helper_method :get_free
  helper_method :notify_user

  BRAND_NAME = 'Classfinder++'.freeze

  def meta_title(title)
    [title, BRAND_NAME].reject(&:empty?).join(' | ')
  end

  private

  def current_user
    #fixme please try  and catch when User.find(session[:user_id]) is nil

    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      session.delete(:user_id)
      session[:user_id] = nil
    end
  end

  def authenticate_user!
    if current_user.nil?
      flash[:danger] = 'In order to use this feature please sign up.'
      redirect_to '/hosts'
      return false
    else
      return true
    end

  end

=begin
    token - is an array with of reg ids
    options - is hash with data to be sebt to the client
=end
  def notify_user(reg_ids = [], options = {})
    fcm = FCM.new("AIzaSyCl5ylWRVZU3ci8DC3if1KOxZ0zN2oS1aY")
    registration_ids= reg_ids  # an array of one or more client registration tokens
    # options = {data: {score: "123"}, collapse_key: "updated_score"}
    response = fcm.send(registration_ids, options)
  end


  # Get your service account's email address and private key from the JSON key file
$service_account_email = "cfapp-c84a4@appspot.gserviceaccount.com"
$private_key = OpenSSL::PKey::RSA.new "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQD3qy0kVMFWgaDC\nK8SjWJqozNVUIV6psH7Iy9wPMdLjsJUBTBjbQ7376nVuuO3M3MH/5nM4qH0nZTFH\n3l4cN+aFF2Grl+LOlwJdBT917TOhxeMvph95sVl7K/LfsfS6PiH09phE532p6ulH\nhPL82U+wssQKcXnsXf3FptmJV5BvrZztaPh+jVJQcZsAVfQjiUP+DlH1AmqATBwz\nfl9tv03Vxul0gohhy53cVxeWRj2mnX2ohZnraSetboWe2EkoAFFu+9aGvsM6hvC6\n4eFOoTf+i/lGXwhQP5qLoEhgPcJH4YGUWRAH+t2t1fcqi38MI5Cid4NuuWxXBI2s\ntzEcrmDtAgMBAAECggEAIMpS34tcePG6+9Tj+Rp13jZsYhye617Y57Mx5KMclZUJ\n9/zVZ6ZS5M5YaOXmuhJaRGFZokfly2L264R8jPDhE4A9KAT5JuVQZJ9uv6loMMQX\nPaDuwY5iV0/sx9gdm3uMGbd9ASvC8/hhlVymonplC3Mc8yMDWPDiye86wEJ4dt3Q\ntVvCVyOmXq/qoC4GMMBjv402EGl/5bzIGu/yqxFCsyYij3aNlVEt4h+DtCui2jJz\nOOEZCL9EIJvJnwolFaQgeOsjHf5o8KE4A5xrqH/PHdaoO6tEJWcUMpubbkKRqKKA\nDmVhRbGco47IFsH6rvmyASD1xazboDRxflKRvoXLswKBgQD9LeLtAiefqcl/Antk\nRSJSJoSJzup/SGda60kj9J7WVYJgzNQCA/blrk8ZQ0/fT5UZ3Pqe48+/cuJhS3KR\n/X1yA+VG3bgRlcxDpV5OlNIzUE0xHQwdhHAsdlJ1VeiXXnZVJ0dtvG9usYwAblRm\ndepcYnpyMBkayQ+4rI3Uf3Rm4wKBgQD6bZKc0KfXHh6BBRFk0INmstduu9aeH2jx\nGzQCfGsppJ8PaTQ4XzwFckbSdMsTa3wZ9Pd5RXrJLVjSsFTeu2xIwCoHGkzrglo/\nlKIbSqsq7ZO3aIp0K8FMtDUptjtiNzXwI1NtcRJytnXnzNk06W7MZs6MMWodtF5M\nKy5maWHR7wKBgQDZQ3dpTGAUc++mPssE0Q8S0FsMp7Q0Zj3Ll/28DUABToAD8cI9\nuIk3sM3QMCNqzzB0cV3g3D57XGtIcyZugcoU/aLTnZFIBfS0WEUFylBYGKEldHfh\nHLXmceNxLbfbrgR+LqbtVLeLlnE+LW/gPXBQt3G8a+ofQktrfyh3IqkRYQKBgQC+\naagr0j98QquBAIB8PktbQCqsSOjj7BAYG84NAdtdm41R43VQU6FIpt6Q0TtD9dsz\nxV6R+DFnXDKIaIjvnmS0YGDUa7wG6mOCqpoj1D+X8XL65uM3d7mPgApYP/ahNEev\n4rxhn7MeQ/wcl1akc8XKZ3UvhbchBO8aTU8HkaNOQwKBgB86qZ6/Drt2DVmFqYgL\nmkkH4SVtps4UpVX3EzlefipN7UEpb4H44vdywR76AkRiUWROeFrIERhMe5Y9s4bw\nnt0ijJx8FsoA9SRG16d6p638qUlTKvZuqs3cQfikDA6baTbWpre+5iN1tdaA8XpV\njm4GaUUQmMw9woCsM0Q4x26d\n-----END PRIVATE KEY-----\n"

def create_custom_token(email)
  now_seconds = Time.now.to_i
  payload = {:iss => $service_account_email,
             :sub => $service_account_email,
             :aud => "https://identitytoolkit.googleapis.com/google.identity.identitytoolkit.v1.IdentityToolkit",
             :iat => now_seconds,
             :exp => now_seconds+(60*60), # Maximum expiration time is one hour
             :uid => email,
             :claims => {:premium_account => false}}
   return JWT.encode payload, $private_key, "RS256"
end
end
