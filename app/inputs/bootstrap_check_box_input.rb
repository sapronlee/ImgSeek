class BootstrapCheckBoxInput < SimpleForm::Inputs::Base
  def input
    "<label>#{@builder.check_box(attribute_name, input_html_options)} #{label_text}</label>".html_safe
  end
end