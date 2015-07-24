class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::Serialization

  before_action :authenticate
  #run authenticate before you run any action

  attr_reader :current_user

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.find_by token: token
    end
  end
end
