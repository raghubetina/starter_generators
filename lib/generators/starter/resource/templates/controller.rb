class <%= plural_name.camelize %>Controller < ApplicationController
  def index
    @<%= plural_name.underscore %> = <%= class_name %>.all

    render("<%= plural_name.underscore %>_templates/index.html.erb")
  end

  def show
    @<%= singular_name.underscore %> = <%= class_name %>.find(params[:id])

    render("<%= plural_name.underscore %>_templates/show.html.erb")
  end

  def new_form
    @<%= singular_name.underscore %> = <%= class_name %>.new

    render("<%= plural_name.underscore %>_templates/new_form.html.erb")
  end

  def create_row
    @<%= singular_name.underscore %> = <%= class_name %>.new

<% attributes.each do |attribute| -%>
    @<%= singular_name.underscore %>.<%= attribute.name %> = params[:<%= attribute.name %>]
<% end -%>

    @<%= singular_name.underscore %>.save

    redirect_to("/<%= @plural_name.underscore %>")
  end

  def edit_form
    @<%= singular_name.underscore %> = <%= class_name %>.find(params[:id])

    render("<%= plural_name.underscore %>_templates/edit_form.html.erb")
  end

  def update_row
    @<%= singular_name.underscore %> = <%= class_name %>.find(params[:id])

<% attributes.each do |attribute| -%>
    @<%= singular_name.underscore %>.<%= attribute.name %> = params[:<%= attribute.name %>]
<% end -%>

    @<%= singular_name.underscore %>.save

    redirect_to("/<%= @plural_name.underscore %>/#{@<%= singular_name.underscore %>.id}")
  end

  def destroy_row
    @<%= singular_name.underscore %> = <%= class_name %>.find(params[:id])

    @<%= singular_name.underscore %>.destroy

    redirect_to("/<%= @plural_name.underscore %>")
  end
end
