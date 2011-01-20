module ApplicationHelper
  def errors_for(attribute, object)
    error_message = ""
    unless object.errors.empty?
      object.errors[attribute].each { |msg| error_message += "#{msg}. " }
    end
    error_message
  end
end
