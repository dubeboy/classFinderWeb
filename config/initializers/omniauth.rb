OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '582267959278-tdom3hq68ik48f86gudb66jn3o02gos5.apps.googleusercontent.com',
           'jszircoZNcJR19XzupVbCYL9', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end