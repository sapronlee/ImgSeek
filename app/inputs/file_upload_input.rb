class FileUploadInput < SimpleForm::Inputs::Base
  def input
    <<-HTML.html_safe
    	<span class='btn btn-success fileinput-button'>
    		<i class='icon-plus icon-white icon-large'></i>
    		<b>#{I18n.translate("fileupload.links.add")}</b>
    		#{@builder.file_field(attribute_name, input_html_options)}
    	</span>
  	HTML
  end
end