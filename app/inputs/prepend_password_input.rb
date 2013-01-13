class PrependPasswordInput < SimpleForm::Inputs::Base
  def input
    "<span class=\"add-on\"><i class=\"#{options[:icon]}\"></i></span>#{@builder.password_field(attribute_name, input_html_options)}".html_safe
  end
end