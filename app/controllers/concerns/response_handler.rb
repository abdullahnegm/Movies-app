module ResponseHandler
  extend ActiveSupport::Concern

  # for responses with one data object only
  def render_success(key, data, status_code)
    render(
      json: {
        success: true,
        key.to_sym => data
      },
      status: status_code
    )
  end

  def render_error(message, status_code)
    render(
      json: {
        success: false,
        message: message
      },
      status: status_code
    )
  end
end