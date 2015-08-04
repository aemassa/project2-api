class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::Serialization

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  # this is new 8-3-15

  before_action :authenticate
  # run authenticate before you run any action

  attr_reader :current_user

  private

  attr_reader :current_user
  # moved attr_reader :current_user down below private 8-3-15

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      @current_user = User.find_by token: token
    end
  end
# added underscore before "options" above 8-3-15. why?
  def record_not_found
    render json: { message: 'Not Found' }, status: :not_found
  end
end
# added 8-3-15
#'events/1'

#current_user.person
