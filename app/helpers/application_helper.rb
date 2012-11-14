# encoding : utf-8
module ApplicationHelper
	def controller_stylesheet_link_tag
    case controller_name
    when "sessions"
      stylesheet_link_tag controller_name
    end
  end

  def controller_javascript_include_tag
    case controller_name
    when ""
      javascript_include_tag controller_name
    end
  end

  def render_page_title(sub_title = nil, space_character = " - ")
    title = @page_title ? "#{@page_title}#{space_character + sub_title if !sub_title.nil?}" : SITE_NAME rescue "SITE_NAME"
    content_tag("title", title, nil, false)
  end

  def controller_and_action_name
    "#{controller_name}-#{action_name}"
  end

  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      type = :success if type == :notice
      type = :error   if type == :alert
      type = :warning if type == :warning
      text = content_tag(:div, link_to("×", "#", :class => "close", "data-dismiss" => "alert") + message, :class => "alert fade in alert-#{type}")
      flash_messages << text if message
    end
    flash_messages.join("\n").html_safe
  end
  
  def bootstrap_alert(message, type)
    text = content_tag(:div, link_to("×", "#", :class => "close", "data-dismiss" => "alert") + message, :class => "alert fade in alert-#{type}")
    text.html_safe
  end

  def error_messages_for(*params)
    options = params.extract_options!.symbolize_keys

    objects = Array.wrap(options.delete(:object) || params).map do |object|
      object = instance_variable_get("@#{object}") unless object.respond_to?(:to_model)
      object = convert_to_model(object)

      if object.class.respond_to?(:model_name)
        options[:object_name] ||= object.class.model_name.human.downcase
      end

      object
    end

    objects.compact!
    count = objects.inject(0) {|sum, object| sum + object.errors.count }

    unless count.zero?
      html = {}
      [:id, :class].each do |key|
        if options.include?(key)
          value = options[key]
          html[key] = value unless value.blank?
        else
          html[key] = 'errorExplanation'
        end
      end
      options[:object_name] ||= params.first

      I18n.with_options :locale => options[:locale], :scope => [:errors, :template] do |locale|
        header_message = if options.include?(:header_message)
          options[:header_message]
        else
          locale.t :header, :count => count, :model => options[:object_name].to_s.gsub('_', ' ')
        end

        message = options.include?(:message) ? options[:message] : locale.t(:body)

        error_messages = objects.sum do |object|
          object.errors.full_messages.map do |msg|
            content_tag(:li, msg)
          end
        end.join.html_safe

        contents = ''
        contents << content_tag(:a, raw("&times;"), :class => "close", "data-dismiss" => :alert) unless options[:close].blank?
        contents << content_tag(options[:header_tag] || :h2, header_message) unless header_message.blank?
        contents << content_tag(:p, message) unless message.blank?
        contents << content_tag(:ul, error_messages)

        content_tag(:div, contents.html_safe, html)
      end
    else
      ''
    end
  end
end
