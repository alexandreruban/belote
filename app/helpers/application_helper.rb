module ApplicationHelper
  def field_errors(record, attribute)
    safe_join record.errors.full_messages_for(attribute).map { |message| tag.div(message, class: "field-error") }
  end
end
