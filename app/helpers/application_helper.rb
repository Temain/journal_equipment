module ApplicationHelper

  def field_with_errors(object, method, &block)
    if block_given?
      if object.errors[method].empty?
        concat capture(&block)
      else
        concat content_tag(:div, capture(&block), class: "field_with_errors")
      end
    end
  end

end
