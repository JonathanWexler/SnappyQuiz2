class ErrorsController < ApplicationController
	layout 'main'
  def file_not_found
  end

  def unprocessable
  end

  def internal_server_error
  end
end
