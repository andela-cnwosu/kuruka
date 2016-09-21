module ResponseHelper
  def respond_message(status, message)
    locals = { status: status, message: message }
    render partial: 'application/message', locals: locals
  end

  def respond_json_error(message)
    render json: {success: false, errors: message}
  end
end
