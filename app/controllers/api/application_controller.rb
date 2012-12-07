class Api::ApplicationController < ApplicationController
  
  before_filter :set_default_response_format
  skip_before_filter :verify_authenticity_token
  
  respond_to :json
  
  protected
    def set_default_response_format
      request.format = 'json'.to_sym if params[:format].nil?
    end
end
