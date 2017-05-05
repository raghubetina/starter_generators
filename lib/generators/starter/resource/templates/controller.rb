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

<% if named_routes? -%>
    if @<%= singular_name.underscore %>.save
      redirect_to :back, :notice => "<%= singular_name.humanize %> created successfully."
    else
      render("<%= plural_name.underscore %>_templates/new_form.html.erb")
    end
<% else -%>
    save_status = @<%= singular_name.underscore %>.save

    if save_status == true
      redirect_to("/<%= @plural_name.underscore %>)
    else
      render("<%= plural_name.underscore %>_templates/new_form.html.erb")
    end
<% end -%>
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

<% if named_routes? -%>
    if @<%= singular_name.underscore %>.save
      redirect_to <%= singular_name.underscore %>_url(@<%= singular_name %>.id), :notice => "<%= singular_name.humanize %> updated successfully."
    else
      render("<%= plural_name.underscore %>_templates/edit_form.html.erb")
    end
<% else -%>
    save_status = @<%= singular_name.underscore %>.save

    if save_status == true
      redirect_to("/<%= @plural_name.underscore %>/#{@<%= singular_name.underscore %>.id}")
    else
      render("<%= plural_name.underscore %>_templates/edit_form.html.erb")
    end
<% end -%>
  end

  def destroy_row
    @<%= singular_name.underscore %> = <%= class_name %>.find(params[:id])

    @<%= singular_name.underscore %>.destroy

    redirect_to("/<%= @plural_name.underscore %>)
  end
end
